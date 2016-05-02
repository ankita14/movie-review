admin = Admin.find_or_initialize_by(email: 'admin@example.com')
admin.password = 'password'
admin.password_confirmation = 'password'
admin.username = 'admin'
admin.save!

# unless Rails.env.production?
  connection = ActiveRecord::Base.connection

  sql = File.read('db/movies.sql')
  statements = sql.split(/;$/)
  statements.pop

  ActiveRecord::Base.transaction do	 
    statements.each do |statement| 	 
      connection.execute(statement)
    end
  end

  sql = File.read('db/reviews.sql')
  statements = sql.split(/;$/)
  statements.pop

  ActiveRecord::Base.transaction do  
    statements.each do |statement|   
      connection.execute(statement)
    end
  end

  sql = File.read('db/users.sql')
  statements = sql.split(/;$/)
  statements.pop
  
  ActiveRecord::Base.transaction do  
    statements.each do |statement|   
      connection.execute(statement)
    end
  end


# end