# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'rack/test'
require 'sinatra/async/test'

require_relative '../application_controller.rb'

describe ApplicationController, type: :controller do
  include Sinatra::Async::Test::Methods

  def app
    Sinatra::Application
  end

  describe 'GET index' do
    it 'renders the index template' do
      aget '/'
      expect(last_response.status).to eq(200)
    end
  end
end
