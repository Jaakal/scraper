# frozen_string_literal: true

require 'sinatra'
require 'sinatra/base'
require 'sinatra/async'
require_relative 'models/book_depository_scraper.rb'

# set :root, File.dirname(__FILE__)
set :server, 'thin'

class ApplicationController < Sinatra::Base
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

      body do
        @input = params['book-title']
        @active = @input.length.positive? ? ' active animation-on' : ''
        @books = scraper.books
        @search_results = @books.empty? ? ' display-none' : ''
        erb :search_results
      end
    end
  end
end

ApplicationController.run!
