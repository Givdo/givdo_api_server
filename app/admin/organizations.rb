ActiveAdmin.register Organization do
  permit_params :name, :facebook_id, :mission, :state, :city, :zip, :street

  filter :name, :as => :string
  filter :mission, :as => :string

  index do
    selectable_column
    id_column
    column :facebook_id
    column :name
    column :mission
    column :created_at
    column :cached_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :facebook_id
      row :name
      row :mission
      row :state
      row :city
      row :zip
      row :street
      row :picture do
        image_tag resource.picture
      end
      row :cached_at
      row :created_at
      row :updated_at
    end
  end

  after_create { UpdateOrganizationJob.perform_later(resource) }

  form do |f|
    f.semantic_errors
    f.inputs "Organization details" do
      f.input :facebook_id
      f.input :name
      f.input :mission
      f.input :state
      f.input :city
      f.input :zip
      f.input :street
    end
    f.actions
  end
end
