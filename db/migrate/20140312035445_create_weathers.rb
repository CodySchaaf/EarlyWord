class CreateWeathers < ActiveRecord::Migration
  def change
    create_table :weathers do |t|
      t.integer :zip_code
      t.text :json
      t.datetime :updated_at


      t.timestamps
    end
		add_index :weathers, :zip_code
  end
end
