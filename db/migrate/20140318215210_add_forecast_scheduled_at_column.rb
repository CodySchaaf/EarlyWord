class AddForecastScheduledAtColumn < ActiveRecord::Migration
  def change
	  add_column :users, :forecast_scheduled_at, :datetime
	  add_index :users, :forecast_scheduled_at
  end
end
