class CreateCountryWeights < ActiveRecord::Migration[5.0]
  def change
    create_table :country_weights do |t|
      t.string :country
      t.string :amount
    end
  end
end
