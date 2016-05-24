class CreateJoinTableUsersCauses < ActiveRecord::Migration
  def change
    create_join_table :users, :causes do |t|
      t.index [:user_id, :cause_id]
      # t.index [:cause_id, :user_id]
    end
  end
end
