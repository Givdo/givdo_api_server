ActiveAdmin.register Organization, as: 'Scores' do
  actions :all, except: [:new, :create, :edit, :update]

  filter :name, :as => :string

  controller do
    def scoped_collection
      Organization.with_score
    end
  end

  index do
    column :id
    column :name
    column :total_score
  end
end
