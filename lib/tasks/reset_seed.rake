namespace :db do
  namespace :seed do
      task :reset => :environment do
        @environment = ENV['RAILS_ENV'] || 'development'
        @db = YAML.load(File.read('config/database.yml'))
        ActiveRecord::Base.establish_connection @db[@environment]
        ActiveRecord::Base.connection.execute("SET foreign_key_checks = 0;")
        ActiveRecord::Base.connection.tables.each do |table|
          # MySQL
          ActiveRecord::Base.connection.execute("TRUNCATE #{table}") unless table == "schema_migrations"

          # SQLiterails
          # ActiveRecord::Base.connection.execute("DELETE FROM #{table}") unless table == "schema_migrations"
        end
        ActiveRecord::Base.connection.execute("SET foreign_key_checks = 1;")
        ActiveRecord::Base.connection.execute("commit;")
      end
  end
end