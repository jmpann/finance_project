class RemoveStatusFromSearches < ActiveRecord::Migration[5.0]
  def change
    remove_column :searches, :status, :string
  end
end
