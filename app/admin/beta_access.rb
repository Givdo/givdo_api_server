ActiveAdmin.register BetaAccess do
  scope :awaiting, :default => true
  filter :user_name, :as => :string

  actions :all, except: [:new, :create, :edit, :update]

  member_action :grant, method: :put do
    resource.grant!
    redirect_to collection_path, notice: "Access granted to #{resource.user_name}!"
  end

  batch_action :grant do |ids|
    requests = BetaAccess.where(:id => ids)
    grants = requests.map(&:grant!).count(true)
    redirect_to collection_path, alert: "Granted access to #{grants} users!"
  end

  config.batch_actions = false
  index do
    column 'Picture' do |request|
      link_to image_tag(request.user_image), admin_beta_access_path(request)
    end
    column :user_name
    actions :defaults => true do |request|
      link_to 'Grant Access', grant_admin_beta_access_path(request), :method => :put, :data => {:confirm => "Grant access to #{request.user_name}?"}
    end
  end

  show do
    h3 beta_access.user_name
    attributes_table do
      row :user_name
      row :image do
        image_tag beta_access.user_image
      end
      row :created_at
    end
    active_admin_comments
  end
  action_item :grant, :only => :show do
    link_to 'Grant Access', grant_admin_beta_access_path(resource), :method => :put, :data => {:confirm => "Grant access to #{resource.user_name}?"}
  end
end
