namespace :givdo do
  namespace :user do
    desc "Reset user games and activities"
    task :reset, [:email] => :environment do |t, args|
      puts "Reseting user for email #{args.email}..."
      user = User.find_by(email: args.email)

      fail "User not found!" if user.nil?

      user.owned_games.destroy_all
      user.activities.destroy_all
    end
  end
end
