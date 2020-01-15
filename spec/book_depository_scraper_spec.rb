# frozen_string_literal: true

require_relative '../models/book_depository_scraper.rb'
=begin
describe BookDepositoryScraper do
  describe '#initialize' do
    it 'should not return any error' do
      expect { BookDepositoryScraper.new('Alice in Wonderland') }.not_to raise_exception
    end
  end

  describe '#initialize' do
    it 'should return InvalidURIError' do
      expect { BookDepositoryScraper.new("124ä312'4ä-12'ä412") }.to raise_exception(URI::InvalidURIError)
    end
  end

  describe '#initialize' do
    it 'returned book array is not empty' do
      scraper = BookDepositoryScraper.new('Algorithm Design')
      expect(scraper.books.empty?).to eql(false)
    end
  end

  describe '#initialize' do
    it 'returned book array is empty' do
      scraper = BookDepositoryScraper.new('')
      expect(scraper.books.empty?).to eql(true)
    end
  end
end
=end
