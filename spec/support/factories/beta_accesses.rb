FactoryGirl.define do
  factory :beta_access do
    email { user.email }
    user
  end
end
