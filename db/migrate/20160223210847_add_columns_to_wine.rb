class AddColumnsToWine < ActiveRecord::Migration
  def change
    add_column :wines, :country, :string
    add_column :wines, :region, :string
    add_column :wines, :grape, :text
    add_column :wines, :rating, :integer
  end
end
