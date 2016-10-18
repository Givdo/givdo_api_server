namespace :givdo do
  namespace :user do
    desc "Import beta testers from MailChimp"
    task :beta_testers, [:list_id, :api_key] => :environment do |t, args|
      gibbon = Gibbon::Request.new(api_key: args.api_key)

      puts "Retrieving members from list #{args.list_id}..."
      members = gibbon.lists(args.list_id).members.retrieve

      puts "Saving testers..."
      imported_members = members['members'].map do |member|
        begin
          BetaAccess.create!(email: member['email_address'], granted_at: Time.current)
        rescue ActiveRecord::RecordInvalid
          next
        end
      end

      puts "#{imported_members.size} testers imported!"
      puts "Done!"
    end
  end
end
