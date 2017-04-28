class CreateCountryWeights < ActiveRecord::Migration[5.0]
  def change
    create_table :country_weights do |t|
      t.string :country
      t.decimal :amount, precision: 4, scale: 2
    end
  end
end
