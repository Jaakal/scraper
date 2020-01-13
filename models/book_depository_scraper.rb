#! /usr/bin/env ruby
# frozen_string_literal: true

require 'nokogiri'
require 'sinatra'
require 'sinatra/async'
require_relative 'capybara_with_phantom_js'

set :server, 'thin'

class BookDepositoryScraper
  include CapybaraWithPhantomJs
  attr_reader :books, :book_title_to_search

  def initialize(book_name)
    @book_name = book_name
  end

  def search_book_depository
    unless @book_depository_page
      new_session
      search @book_name
      @book_depository_page = Nokogiri::HTML.parse(html)
    end
    @book_depository_page
  end

  def parse_the_results
    @books = {}
    index = 0

    @book_title_to_search = @book_name
    strict_search = @book_title_to_search.include?('"') ? true : false
    @book_title_to_search = @book_title_to_search.tr('"', '')

    @book_depository_page.css('.book-item').each do |book|
      next unless book.css('.unavailable').empty?

      book_title = book.css('.title a').text.strip!

      break if book_title.nil?

      if strict_search
        next unless book_title.downcase == @book_title_to_search.downcase
      else
        next unless book_title.downcase.include?(@book_title_to_search.downcase)
      end

      book_price = book.css('.price').text.split(' ')
      book_format = book.css('.format').text.strip!
      book_image_url = book.css('img')[0]['data-lazy']
      book_link = 'https://www.bookdepository.com/'\
                  + book.css('.title a')[0]['href']

      book_info = [book_title, book_format, book_price[0] + book_price[1],
                   book_image_url, book_link]
      @books[index] = book_info

      index += 1
    end
  end
end
