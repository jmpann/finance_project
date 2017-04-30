class CreateTopHoldings < ActiveRecord::Migration[5.0]
  def change
    create_table :top_holdings do |t|
      t.string :name
      t.float :amount
    end
  end
end
