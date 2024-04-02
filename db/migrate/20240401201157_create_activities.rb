class CreateActivities < ActiveRecord::Migration[7.1]
  def change
    create_table :activities do |t|
      t.string :name
      t.string :description
      t.date :date
      t.datetime :start_time
      t.datetime :finish_time
      t.references :user, null: false, foreign_key: true
      t.references :category, null: true, foreign_key: true
      t.timestamps
    end
  end
end
