class SetGameDefaultToSingle < ActiveRecord::Migration
  def change
    change_column :games, :single, :boolean, :default => true
  end
end
