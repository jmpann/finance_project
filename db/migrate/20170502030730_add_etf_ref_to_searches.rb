class AddEtfRefToSearches < ActiveRecord::Migration[5.0]
  def change
    add_reference :searches, :etf, foreign_key: true
  end
end
