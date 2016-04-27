namespace :givdo do
  namespace :rpush do
    desc "Create a new Rpush::GCM application"
    task :create, [:name, :auth_key] => :environment do |t, args|
      abort "Already exists an app called #{args.name}" if Rpush::Gcm::App.find_by_name(args.name)

      Rpush::Gcm::App.create!(name: args.name, auth_key: args.auth_key, connections: 1)

      puts "App #{args.name} created!"
      puts "Done!"
    end
  end
end
