include ActionDispatch::TestProcess


FactoryGirl.define do
  factory :advertisement do
    company_name 'TestCo'
    link 'example.com'
    image { fixture_file_upload(Rails.root.join('spec/support/fixtures/test_image.jpg'), 'image/jpg') }
  end
end
