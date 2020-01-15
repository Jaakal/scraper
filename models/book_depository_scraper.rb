# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'

class BookDepositoryScraper
  attr_reader :books

  def initialize(book_name)
    @book_name = book_name
    open_session
    parse_results
  end

  private

  def open_session
    search_link = "https://www.bookdepository.com/search?searchTerm="
    search_link += @book_name.strip.tr(' ', '+') 
    search_link += "&search=Find+book"

    @book_depository_search_result = Nokogiri::HTML(open(search_link))
  end

  def parse_results
    @books = []

    strict_search = @book_name.include?('"') ? true : false
    @book_name = @book_name.tr('"', '')
    @book_name.downcase!

    @book_depository_search_result.css('.book-item').each do |book|
      next unless book.css('.unavailable').empty?

      book_title = book.css('.title a').text.strip!

      break if book_title.nil?

      if strict_search
        next unless book_title.downcase == @book_name
      else
        next unless book_title.downcase.include?(@book_name)
      end

      book_price = book.css('.price').text.strip
      book_price = book_price[0...book_price.index("\n")]

      book_format = book.css('.format').text.strip
      book_image_url = book.css('img')[0]['data-lazy']
      book_link = 'https://www.bookdepository.com/'\
                  + book.css('.title a')[0]['href']

      @books.push([book_title, book_format, book_price,
                   book_image_url, book_link])
    end
  end
end