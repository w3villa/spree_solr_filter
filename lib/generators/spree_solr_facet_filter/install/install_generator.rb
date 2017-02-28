module SpreeSolrFacetFilter
module Generators
  class InstallGenerator < Rails::Generators::Base
   # include Rails::Generators::Migration
   
   # source_root File.source_paths



   # def self.source_paths
   #   paths = self.superclass.source_paths
   #   paths << File.expand_path('../templates', "../../#{__FILE__}")
   #   paths << File.expand_path('../templates', "../#{__FILE__}")
   #   paths << File.expand_path('../templates', __FILE__)
   #   paths.flatten
   # end

    class_option :auto_run_migrations, type: :boolean, default: false

    
    #  def copy_migrations
    #    copy_migration "create_stores"
       
    #  end

    # def copy_migration(filename)
    #    if  self.class.migration_exists?("db/migrate","#{filename}")
    #      say_status("skipped", "Migration #{filename}.rb already exists")
    #    else
    #      migration_template "migrations/#{filename}.rb", "db/migrate/#{filename}.rb"
    #    end
    #  end



    def add_migrations
      run 'bundle exec rake railties:install:migrations FROM=spree_solr_facet_filter'
    end

    def run_migrations
       run_migrations = options[:auto_run_migrations] || ['', 'y', 'Y'].include?(ask 'Would you like to run the migrations now? [Y/n]')
       if run_migrations
         run 'bundle exec rake db:migrate'
       else
         puts 'Skipping rake db:migrate, don\'t forget to run it!'
       end
     end
   end
 end
end