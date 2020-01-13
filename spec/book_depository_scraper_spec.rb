# frozen_string_literal: true

require_relative '../models/book_depository_scraper.rb'

describe BookDepositoryScraper do
  let(:session) { BookDepositoryScraper.new('Algorithm Design') }

  describe '#initialize' do
    it 'should not return any error' do
      expect { BookDepositoryScraper.new('Alice in Wonderland') }.not_to raise_exception
    end
  end

  describe '#search_book_depository' do
    it 'should not return any error' do
      expect { session.search_book_depository }.not_to raise_exception
    end
  end

  describe '#parse_the_results' do
    it 'should not return any error' do
      session.search_book_depository
      expect { session.parse_the_results }.not_to raise_exception
    end
  end
end
