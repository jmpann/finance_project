class CreateSeaches < ActiveRecord::Migration[5.0]
  def change
    create_table :searches do |t|
      t.string :ticker

      t.timestamps
    end
  end
end
