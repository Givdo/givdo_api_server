class RemoveUserProviderDefault < ActiveRecord::Migration
  def up
    change_column_default(:users, :provider, nil)
    change_column_default(:users, :uid, nil)
  end

  def down
    change_column_default(:users, :provider, 'email')
    change_column_default(:users, :uid, '')
  end
end
