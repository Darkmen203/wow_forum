class AddRepForUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :reputation, :integer, default: 0, null: false

  end
end
