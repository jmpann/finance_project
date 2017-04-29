class Etf < ApplicationRecord
  has_many :top_holdings
  has_many :sector_allocations
  has_many :country_weights

  require 'rubygems'
  require 'nokogiri'

  def self.new_from_scrape(ticker_symbol, page)
    fund_name = page.css('h1').text.strip
    fund_objective = page.css('.overview.tab_section').css('.col2s.leftm').css('p').first.text
    @etf = new(ticker: ticker_symbol, name: fund_name, objective: fund_objective)
    @etf.save
    @etf
  end

  def self.find_by_ticker(ticker_symbol)
    where(ticker: ticker_symbol).first
  end

end
