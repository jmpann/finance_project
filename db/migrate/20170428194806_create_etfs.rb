class CreateEtfs < ActiveRecord::Migration[5.0]
  def change
    create_table :etfs do |t|
      t.string :ticker
      t.string :name
      t.text :objective

      t.timestamps
    end
  end
end
