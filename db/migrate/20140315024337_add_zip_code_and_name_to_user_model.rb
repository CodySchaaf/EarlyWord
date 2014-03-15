class AddZipCodeAndNameToUserModel < ActiveRecord::Migration
  def change
		add_column :users, :zip_code_id, :integer
		add_column :users, :name, :string
		add_index :users, :zip_code_id
  end
end
