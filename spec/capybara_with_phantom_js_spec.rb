# frozen_string_literal: true

require_relative '../models/capybara_with_phantom_js.rb'

describe CapybaraWithPhantomJs do
  include CapybaraWithPhantomJs

  describe '#new_session' do
    it 'should return status success' do
      expect(new_session['status']).to eq('success')
    end
  end

  describe '#search' do
    it 'should not return any error' do
      new_session
      expect { search('*') }.not_to raise_exception
    end
  end

  describe '#html' do
    it 'should return HTML document' do
      new_session
      expect(html.include?('html')).to eq(true)
    end
  end
end
