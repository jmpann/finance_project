class SectorAllocation < ApplicationRecord
  belongs_to :etf

  def self.new_from_scrape(ticker_symbol, page, etf_id)
    sectors_html_fragment = page.css('#SectorsAllocChart').text
    xml_page = Nokogiri::XML(sectors_html_fragment)
    sector_allocation_table_rows = xml_page.css('attribute')
    sector_allocation_table_rows.each do |row|
      sector_amount = row.css('value').text
      sector_name = row.css('label').text
      SectorAllocation.create(sector: sector_name, amount: sector_amount, etf_id: etf_id)
    end
  end
end
