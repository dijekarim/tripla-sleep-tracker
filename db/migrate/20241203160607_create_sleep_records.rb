class CreateSleepRecords < ActiveRecord::Migration[7.2]
  def change
    create_table :sleep_records do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :clock_in
      t.datetime :clock_out

      t.timestamps
    end

    add_index :sleep_records, :clock_in
    add_index :sleep_records, :clock_out
  end
end
