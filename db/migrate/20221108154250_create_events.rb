class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.references :schedule, null: false, foreign_key: true
      t.references :user, null: true, foreign_key: true
      t.integer :kind
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
