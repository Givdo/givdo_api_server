class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers, :id => false do |t|
      t.references :user, :index => true, :foreign_key => true
      t.references :option, :index => true, :foreign_key => true
      t.datetime :updated_at, :null => false
    end
  end
end
