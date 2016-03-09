namespace :givdo do
  namespace :organizations do
    desc "Cache data from Facebook API to database"
    task :cache => :environment do
      Organization.cache_due.find_each do |organization|
        print "Caching #{organization.name} (#{organization.facebook_id}) ... "
        begin
          UpdateOrganizationJob.perform_later(organization)
          puts "OK"
        rescue => e
          puts "ERROR [#{e.message}]"
        end
      end
    end
  end
end
