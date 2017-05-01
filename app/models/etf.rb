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

  def to_csv
      attributes = %w{name amount}

      CSV.generate(headers: true) do |csv|
        csv << attributes

        self.top_holdings.each do |top_holding|
          csv << attributes.map{ |attr| top_holding.send(attr) }
        end
        csv << [" "]
        csv << ["sector", "weight(%)"]

        self.sector_allocations.each do |sector_allocation|
          csv << attributes.map{ |attr| sector_allocation.send(attr) }
        end
        csv << [" "]
        csv << ["country", "weight(%)"]

        self.country_weights.each do |country_weight|
          csv << attributes.map{ |attr| country_weight.send(attr) }
        end
      end
    end

end
