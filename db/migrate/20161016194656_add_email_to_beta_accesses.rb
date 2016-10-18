class AddEmailToBetaAccesses < ActiveRecord::Migration
  def change
    add_column :beta_accesses, :email, :string
    add_index :beta_accesses, :email, unique: true
  end
end
