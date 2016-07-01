namespace :givdo do
  namespace :trivia do
    task :import, [:filename] => :environment do |t, args|
      sheet = Roo::Excelx.new(args.filename)

      puts "Importing trivias from #{args.filename}..."

      Givdo::TriviaImporter.import!(sheet)

      puts "Done!"
    end
  end
end
