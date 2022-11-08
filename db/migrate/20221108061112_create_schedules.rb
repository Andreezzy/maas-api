class CreateSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :schedules do |t|
      t.references :company, null: false, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.time :min_time
      t.time :max_time

      t.timestamps
    end
  end
end
