class AddRateToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :rate, :integer, default: 0
  end
end
