class CreateActivities < ActiveRecord::Migration[7.1]
  def change
    create_table :activities do |t|
      t.string :name
      t.string :description
      t.date :date
      t.time :start_time
      t.time :finish_time
      t.string :category

      t.timestamps
    end
  end
end
