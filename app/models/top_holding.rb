class TopHolding < ApplicationRecord
  belongs_to :etf

  def self.new_from_scrape(ticker_symbol, page, etf_id)
    fund_holdings_array = page.css('#FUND_TOP_TEN_HOLDINGS').css('tr')[1...10]
    fund_holdings_array.each do |holding|
      holding_name = holding.css('.label').text
      holding_shares = holding.css('.data')[1].text.gsub!(/,/,'').to_i
      TopHolding.create(name: holding_name, shares: holding_shares, etf_id: etf_id)
    end
  end
end
