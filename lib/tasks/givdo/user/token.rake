namespace :givdo do
  namespace :user do
    desc "Generates a JWT token for a user"
    task :token, [:email, :expires_in] => :environment do |t, args|
      expires_in = args.expires_in || 60_000
      user = User.find_by(email: args.email)

      puts "Generating JWT token for #{args.email}..."

      fail "User not found" if user.nil?

      session = Givdo::TokenAuth::Session.new(user, expires_in)

      puts "Your token is #{session.token}"
    end
  end
end
