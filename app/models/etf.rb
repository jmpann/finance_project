class Etf < ApplicationRecord
  has_many :top_holdings
  has_many :sector_allocations
  has_many :country_weights
  has_many :searches

  require 'rubygems'
  require 'nokogiri'

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

      if !sector_allocations.empty?
        csv << [" "]
        csv << ["sector", "weight(%)"]

        self.sector_allocations.each do |sector_allocation|
          csv << attributes.map{ |attr| sector_allocation.send(attr) }
        end
      end

      if !country_weights.empty?
        csv << [" "]
        csv << ["country", "weight(%)"]

        self.country_weights.each do |country_weight|
          csv << attributes.map{ |attr| country_weight.send(attr) }
        end
      end
    end
  end

end
