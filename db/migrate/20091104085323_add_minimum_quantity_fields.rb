class AddMinimumQuantityFields < ActiveRecord::Migration
  def self.up
		add_column :variants, :minimum_quantity, :integer
		add_column :products, :minimun_quantity, :integer
  end

  def self.down
		remove_column :products, :minimun_quantity
		remove_column :variants, :minimum_quantity
  end
end