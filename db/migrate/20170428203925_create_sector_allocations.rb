class CreateSectorAllocations < ActiveRecord::Migration[5.0]
  def change
    create_table :sector_allocations do |t|
      t.string :sector
      t.string :amount
    end
  end
end
