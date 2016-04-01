ActiveAdmin.register Cycle do
  config.batch_actions = false

  filter :ended_at, default: true
  filter :created_at

  actions :all, except: [:new, :create, :edit, :update, :show]

  index do
    id_column
    column :created_at
    column :ended_at
    column :score
    actions defaults: false do |cycle|
      link_to 'Stop', stop_admin_cycle_path(cycle), method: :put if cycle.started?
    end
  end

  action_item :start, only: :index do
    link_to 'Start cycle', start_admin_cycles_path
  end

  collection_action :start, method: :get do
    Cycle::Start.call

    redirect_to collection_path, notice: 'New cycle started!'
  end

  member_action :stop, method: :put do
    StopCycleJob.perform_later(resource.id)

    redirect_to collection_path, notice: 'Cycle stoped!'
  end

  controller do
    def current_cycle
      @current_cycle ||= Cycle.current
    end
  end
end
