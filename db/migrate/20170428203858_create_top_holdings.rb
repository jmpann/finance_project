class CreateTopHoldings < ActiveRecord::Migration[5.0]
  def change
    create_table :top_holdings do |t|
      t.string :name
      t.string :amount
    end
  end
end
