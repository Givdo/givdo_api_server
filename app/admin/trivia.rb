ActiveAdmin.register Trivia do
  permit_params :question, :correct_option_id, :category_id

  filter :category
  filter :created_at

  show do
    attributes_table do
      row :id
      row :category
      row :correct_option
      row :question
      row :created_at
      row :updated_at
    end

    panel 'Options' do
      attributes_table_for resource.options do
        row :id
        row :text
        row :created_at
        row :updated_at
      end
    end
  end

  form do |f|
    f.inputs 'Trivia Details' do
      f.input :category
      f.input :correct_option, member_label: :text, collection: resource.options
      f.input :question
    end

    f.inputs 'Options' do
      f.has_many :options, allow_destroy: true, new_record: 'Add New' do |o|
        o.input :text
      end
    end

    f.actions
  end
end
