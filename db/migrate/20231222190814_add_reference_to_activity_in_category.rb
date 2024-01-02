class AddReferenceToActivityInCategory < ActiveRecord::Migration[7.1]
  def change
    add_reference :categories, :activity, null: true, foreign_key: true
  end
end
