# frozen_string_literal: true

require_relative 'models/book_depository_scraper.rb'

class AsyncTest < Sinatra::Base
  register Sinatra::Async

  aget '/' do
    body do
      @input = ''
      @active = ''
      @books = {}
      erb :index
    end
  end

  apost '/' do
    EM.next_tick do
      scraper = BookDepositoryScraper.new(params['book-title'])
      scraper.search_book_depository
      scraper.parse_the_results

      body do
        @input = scraper.book_title_to_search
        @active = @input.length.positive? ? ' active animation-on' : ''
        @books = scraper.books
        @search_results = @books.empty? ? ' display-none' : ''
        erb :search_results
      end
    end
  end
end

AsyncTest.run!
