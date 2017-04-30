class TopHolding < ApplicationRecord
  belongs_to :etf

  def self.new_from_scrape(ticker_symbol, page, etf_id)
    fund_holdings_array = page.css('#FUND_TOP_TEN_HOLDINGS').css('tr')[1...10]
    fund_holdings_array.each do |holding|
      holding_name = holding.css('.label').text
      holding_amount = holding.css('.data').first.text.to_f
      TopHolding.create(name: holding_name, amount: holding_amount, etf_id: etf_id)
    end
  end
end
