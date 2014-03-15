class AddZipCodeAndNameToUserModel < ActiveRecord::Migration
  def change
		add_column :users, :zip_code, :string
		add_column :users, :name, :string
		add_index :users, :zip_code
  end
end
