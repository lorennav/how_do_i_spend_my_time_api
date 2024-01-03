class AddUserRefToActivities < ActiveRecord::Migration[7.1]
  def change
    add_reference :activities, :user, null: false, foreign_key: true
  end
end
