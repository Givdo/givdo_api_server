ActiveAdmin.register User do
  permit_params :name

  index do
    selectable_column
    id_column
    column :name
    column :nickname
    column :organization
    column :created_at
    actions
  end

  filter :name
  filter :email
  filter :nickname
  filter :created_at

  form do |f|
    f.inputs "User Details" do
      f.input :name
      f.input :nickname
      f.input :badges
      f.input :causes
      f.input :organization
      f.input :provider
      f.input :email
      f.input :image
      f.input :cover
    end
    f.actions
  end
end


