class CreateBetaAccesses < ActiveRecord::Migration
  def up
    create_table :beta_accesses do |t|
      t.references :user
      t.datetime :granted_at

      t.timestamps null: false
    end

    User.all.map{|user| BetaAccess.new(:user => user)}.each(&:grant!).each(&:save)
  end

  def down
    drop_table :beta_accesses
  end
end
