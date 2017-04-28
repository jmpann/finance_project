class AddEtfRefToTopHoldings < ActiveRecord::Migration[5.0]
  def change
    add_reference :top_holdings, :etf, foreign_key: true
  end
end
