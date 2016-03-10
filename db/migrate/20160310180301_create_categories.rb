class CreateCategories < ActiveRecord::Migration
  def up
    create_table :categories do |t|
      t.string :name
    end

    add_reference :games, :category
    add_reference :trivia, :category
  end

  def down
    remove_reference :games, :category
    remove_reference :trivia, :category

    drop_table :categories
  end
end
