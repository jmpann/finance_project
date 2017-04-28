class AddEtfRefToSectorAllocations < ActiveRecord::Migration[5.0]
  def change
    add_reference :sector_allocations, :etf, foreign_key: true
  end
end
