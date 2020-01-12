#! /usr/bin/env ruby
# frozen_string_literal: true

# require 'proxycrawl'
require 'nokogiri'
require 'sinatra'

require_relative 'lib/capybara_with_phantom_js'

require 'sinatra/async'

set :server, 'thin'

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

class AsyncTest < Sinatra::Base
  register Sinatra::Async

  # aget '/' do
  #   body "hello async"
  # end

  # aget '/delay/:n' do |n|
  #   EM.add_timer(n.to_i) { body { "delayed for #{n} seconds" } }
  # end

  aget '/' do
    body {
      @input = ''
      @books = {}
      erb :index
    }
  end

  apost '/' do
    puts params.to_s

    EM.next_tick do
      doc = BookDepositoryScraper.new(params['book-name'])
      doc = doc.book_depository_page
      
      @books = {}
      index = 0
      doc.css('.book-item').each do |book|
        next unless book.css('.unavailable').empty?
      
        book_title = book.css('.title a').text.strip!
      
        next unless book_title.downcase == params['book-name'].downcase
      
        book_price = book.css('.price').text.split(' ')
        book_format = book.css('.format').text.strip!
        book_image_url = book.css('img')[0]['src']
        book_link = 'https://www.bookdepository.com/' + book.css('.title a')[0]['href']
        
        book_info =[params['book-name'], book_format, book_price[0] + book_price[1], book_image_url, book_link]
        @books[index] = book_info
        
        index += 1

        puts '--------------------------'
        puts "#{book_title} #{book_format} #{book_price[0] + book_price[1]}"
        puts "URL: #{book_image_url}"
        puts "Link: #{book_link}"
        puts '--------------------------'
      end
      puts @books.to_s
      body { 
        @input = params['book-name'] + ' + Success'
        @books
        erb :index 
      }
    end
    
  end

  # apost '/delay' do
  #   puts params.to_s
  #   EM.add_timer(5) { body { "delayed for 5 seconds" } }
  #   # erb :index
  # end

end

AsyncTest.run!

# get '/' do
#     erb :index
# end

# post '/' do
#   puts params.to_s
#   erb :index
# end





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
