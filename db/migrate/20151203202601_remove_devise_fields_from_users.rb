class RemoveDeviseFieldsFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :encrypted_password
    remove_column :users, :reset_password_token
    remove_column :users, :reset_password_sent_at
    remove_column :users, :remember_created_at
    remove_column :users, :sign_in_count
    remove_column :users, :current_sign_in_at
    remove_column :users, :last_sign_in_at
    remove_column :users, :current_sign_in_ip
    remove_column :users, :last_sign_in_ip
    remove_column :users, :confirmation_token
    remove_column :users, :confirmed_at
    remove_column :users, :confirmation_sent_at
    remove_column :users, :unconfirmed_email
    remove_column :users, :tokens
  end

  def down
    add_column :users, :encrypted_password,     :string, :default => '', :null => false
    add_column :users, :reset_password_token,   :string
    add_column :users, :reset_password_sent_at, :datetime
    add_column :users, :remember_created_at,    :datetime
    add_column :users, :sign_in_count,          :integer, :default => 0, :null => false
    add_column :users, :current_sign_in_at,     :datetime
    add_column :users, :last_sign_in_at,        :datetime
    add_column :users, :current_sign_in_ip,     :string
    add_column :users, :last_sign_in_ip,        :string
    add_column :users, :confirmation_token,     :string
    add_column :users, :confirmed_at,           :datetime
    add_column :users, :confirmation_sent_at,   :datetime
    add_column :users, :unconfirmed_email,      :string
    add_column :users, :tokens,                 :text

    add_index :users, :reset_password_token, :unique => true
    add_index :users, [:uid, :provider], :unique => true
  end
end
