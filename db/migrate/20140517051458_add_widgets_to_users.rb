class AddWidgetsToUsers < ActiveRecord::Migration
  def change
		add_column :users, :widget_1, :integer, default: nil
		add_column :users, :widget_2, :integer, default: nil
		add_column :users, :widget_3, :integer, default: nil
		add_column :users, :widget_4, :integer, default: nil
		add_column :users, :widget_5, :integer, default: nil
  end
end
