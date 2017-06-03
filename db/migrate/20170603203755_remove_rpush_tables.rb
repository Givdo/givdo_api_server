class RemoveRpushTables < ActiveRecord::Migration
  def change
    drop_table :rpush_apps
    drop_table :rpush_feedback
    drop_table :rpush_notifications
  end
end
