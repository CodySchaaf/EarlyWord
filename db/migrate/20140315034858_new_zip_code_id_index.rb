class NewZipCodeIdIndex < ActiveRecord::Migration
  def change
		remove_index :weathers, :zip_code
		add_index :weathers, :zip_code, unique: true
  end
end
