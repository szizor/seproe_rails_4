class AddAccountIdToListings < ActiveRecord::Migration
  def change
    add_column :listings, :account_id, :integer
  end
end
