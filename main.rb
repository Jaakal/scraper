#! /usr/bin/env ruby
# frozen_string_literal: true

# require 'proxycrawl'
require 'nokogiri'
require 'sinatra'

require_relative 'lib/capybara_with_phantom_js'

get '/' do
  erb :index
end

class BookDepositoryScraper
  include CapybaraWithPhantomJs

  def initialize(book_name)
    @book_name = book_name
  end

  # Get the Google Plus page and locally cache it in an instance variable
  def book_depository_page
    unless @book_depository_page
      new_session
      visit @book_name
      @book_depository_page = Nokogiri::HTML.parse(html)
    end
    @book_depository_page
  end
end

=begin
book1_title = 'The Algorithm Design Manual'
book2_title = 'Data Structures and Algorithm Analysis in C++'
book3_title = 'Algorithm Design'

doc = BookDepositoryScraper.new(book3_title)

doc = doc.book_depository_page

doc.css('.book-item').each do |book|
  next unless book.css('.unavailable').empty?

  book_title = book.css('.title a').text.strip!

  next unless book_title.downcase == book3_title.downcase

  book_price = book.css('.price').text.split(' ')
  book_format = book.css('.format').text.strip!
  book_image_url = book.css('img')[0]['src']
  book_link = 'https://www.bookdepository.com/' + book.css('.title a')[0]['href']
  puts '--------------------------'
  puts "#{book_title} #{book_format} #{book_price[0] + book_price[1]}"
  puts "URL: #{book_image_url}"
  puts "Link: #{book_link}"
  puts '--------------------------'
end

=end
