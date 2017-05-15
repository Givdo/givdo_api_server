ActiveAdmin.register Advertisement do
  permit_params :company_name, :image, :link, :default, :active


  form do |f|
    f.inputs "Advertisement Details" do
      f.input :default
      f.input :active
      f.input :company_name
      f.input :link
      f.input :image
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :company_name
      row :image do
        image_tag advertisement.image_url
      end
      row :link
      row :default
      row :active
      row :impressions
      row :clicks
      row :created_at
      row :updated_at
    end
  end
end
