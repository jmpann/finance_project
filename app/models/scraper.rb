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
      self.etf_from_scrape(ticker_symbol, page)
    end
  end

  def self.etf_from_scrape(ticker_symbol, page)
    fund_name = page.css('h1').text.strip
    fund_objective = page.css('.overview.tab_section').css('.col2s.leftm').css('p').first.text
    @etf = Etf.create(ticker: ticker_symbol, name: fund_name, objective: fund_objective)
    self.etf_holdings_from_scrape(page, @etf.id)
    @etf
  end

  def self.etf_holdings_from_scrape(page, etf_id)
    self.top_holdings(page, etf_id)
    self.country_weights(page, etf_id)
    self.sector_allocation(page, etf_id)
  end

  def self.top_holdings(page, etf_id)
    fund_holdings_array = page.css('#FUND_TOP_TEN_HOLDINGS').css('tr')[1...10]
    fund_holdings_array.each do |holding|
      holding_name = holding.css('.label').text
      holding_amount = holding.css('.data')[-1].text.gsub!(/,/,'').to_i
      TopHolding.create(name: holding_name, amount: holding_amount, etf_id: etf_id)
    end
  end

  def self.country_weights(page, etf_id)
    country_html_fragment = page.css('.holdings').css('.sect')[-1]
    country_allocation_table_rows = country_html_fragment.css('tr')
    country_allocation_table_rows.each do |row|
      country_name = row.css('.label').text
      country_amount = row.css('.data').text.to_f
      CountryWeight.create(name: country_name, amount: country_amount, etf_id: etf_id)
    end
  end

  def self.sector_allocation(page, etf_id)
    sectors_html_fragment = page.css('#SectorsAllocChart').text
    xml_page = Nokogiri::XML(sectors_html_fragment)
    sector_allocation_table_rows = xml_page.css('attribute')
    sector_allocation_table_rows.each do |row|
      sector_amount = row.css('value').text.to_f
      sector_name = row.css('label').text
      SectorAllocation.create(name: sector_name, amount: sector_amount, etf_id: etf_id)
    end
  end

end
