# Usage: rake "givdo:admin:create['USER_EMAIL', 'USER_PASSWORD']"

namespace :givdo do
  namespace :admin do
    desc "Create admin user"
    task :create, [:email, :password] => :environment do |t, args|
      AdminUser.create!({
        :email => args.email,
        :password => args.password,
        :password_confirmation => args.password
      })
    end
  end
end
