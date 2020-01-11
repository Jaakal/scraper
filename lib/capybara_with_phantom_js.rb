# frozen_string_literal: true

require 'capybara'
require 'capybara/poltergeist'
require 'phantomjs'

module CapybaraWithPhantomJs
  include Capybara

  # Create a new PhantomJS session in Capybara
  def new_session
    # Register PhantomJS (aka poltergeist) as the driver to use
    Phantomjs.path
    Capybara.register_driver :poltergeist do |app|
      Capybara::Poltergeist::Driver.new(app, phantomjs: Phantomjs.path)
    end

    # Use XPath as the default selector for the find method
    Capybara.default_selector = :xpath

    # Start up a new thread
    @session = Capybara::Session.new(:poltergeist)

    # Report using a particular user agent
    @session.driver.headers = { 'User-Agent' =>
      'Mozilla/5.0 (Macintosh; Intel Mac OS X)' }

    # Return the driver's session
    @session.visit('https://www.bookdepository.com/')
  end

  def visit(book_name)
    input = @session.fill_in('searchTerm', with: book_name)
    input.send_keys :enter
    loading_string = 'loading..'
 
    until @session.html.include?('search-page')
      loading_string = loader(loading_string)
    end

    until @session.html.include?("class=\"lazy loaded\"")
      loading_string = loader(loading_string)
    end
  end

  # Returns the current session's page
  def html
    @session.html
  end

  private

  def loader(loading_string)
    system('clear') || system('cls')
    puts loading_string
    sleep 0.1
    loading_string + '.'
  end
end
