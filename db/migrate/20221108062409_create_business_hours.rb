class CreateBusinessHours < ActiveRecord::Migration[7.0]
  def change
    create_table :business_hours do |t|
      t.references :schedule, null: false, foreign_key: true
      t.integer :day_of_week
      t.time :start_time
      t.time :end_time

      t.timestamps
    end
  end
end
