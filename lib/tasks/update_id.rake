namespace :database do
	desc "Detect database that's being used and then increment its id"
	task autoincrement: :environment do

		tables = ["users", "movies", "critics_ratings"]
		tables.each do |table|
		  result = ActiveRecord::Base.connection.execute("SELECT id FROM #{table} ORDER BY id DESC LIMIT 1")
		  if result.any?
		    ai_val = result.first['id'].to_i + 1
		    puts "Resetting auto increment ID for #{table} to #{ai_val}"
		    ActiveRecord::Base.connection.execute("ALTER SEQUENCE #{table}_id_seq RESTART WITH #{ai_val}")
		  end
		end

	end
end
