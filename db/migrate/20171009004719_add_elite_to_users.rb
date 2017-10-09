class AddEliteToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :elite, :boolean, default: false
  end
end
