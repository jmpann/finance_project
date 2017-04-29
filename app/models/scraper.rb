class Scraper < ApplicationRecord
  require 'mechanize'

  BASE_URL="https://www.spdrs.com/product/fund.seam?ticker="

  def self.new_from_lookup(ticker_symbol)
    query_url = BASE_URL+ticker_symbol
    @agent = Mechanize.new
    page = @agent.get(query_url)
    query_check = page.css('title').text
    if (query_check == "SPDR: SYSTEM ERROR")
      nil
    else
      @etf = Etf.new_from_scrape(ticker_symbol, page)
      TopHolding.new_from_scrape(ticker_symbol, page, @etf.id)
      SectorAllocation.new_from_scrape(ticker_symbol, page, @etf.id)
      CountryWeight.new_from_scrape(ticker_symbol, page, @etf.id)
    end
  end

end
