require 'rails/generators/active_record'

module ArtisanEngine
  module Generators
    module Attachability
      class InstallGenerator < ActiveRecord::Generators::Base

        argument    :name, :default => 'attachability'
        source_root File.expand_path( '../templates', __FILE__ )
        
        def copy_installation_migration
          migration_template 'migrations/install_attachability.rb', 
                             'db/migrate/install_attachability.rb'
        end
        
      end
    end
  end
end