class ChangeZipCodeIdToWeatherIdOnUsersTable < ActiveRecord::Migration
  def change
	  rename_column :users, :zip_code_id, :weather_id
  end
end
