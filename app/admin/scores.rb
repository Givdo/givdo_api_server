ActiveAdmin.register Organization, as: 'Current Scores' do
  actions :all, except: [:new, :create, :edit, :update]

  filter :name, :as => :string

  controller do
    def scoped_collection
      current_cycle = Cycle.current
      Organization.scores_between(current_cycle.created_at, Time.current)
    end
  end

  index do
    column :id
    column :name
    column :total_score
  end
end
