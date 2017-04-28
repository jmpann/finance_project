class AddEtfRefToCountryWeights < ActiveRecord::Migration[5.0]
  def change
    add_reference :country_weights, :etf, foreign_key: true
  end
end
