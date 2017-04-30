class CountryWeight < ApplicationRecord
  belongs_to :etf

  def self.new_from_scrape(ticker_symbol, page, etf_id)
    country_html_fragment = page.css('.holdings').css('.sect')[-1]
    country_allocation_table_rows = country_html_fragment.css('tr')
    country_allocation_table_rows.each do |row|
      country_name = row.css('.label').text
      country_amount = row.css('.data').text.to_f
      CountryWeight.create(name: country_name, amount: country_amount, etf_id: etf_id)
    end
  end
end
