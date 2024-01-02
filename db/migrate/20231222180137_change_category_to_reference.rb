class ChangeCategoryToReference < ActiveRecord::Migration[7.1]
  def change
    remove_column :activities, :category, :string
    add_reference :activities, :category, null: true, foreign_key: true
  end
end

