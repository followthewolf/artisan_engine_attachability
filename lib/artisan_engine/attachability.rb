require 'artisan_engine/core'
require 'artisan_engine/listability'
require 'artisan_engine/attachability'

module ArtisanEngine
  module Attachability

    # ------------------ Autoload Necessary Modules ------------------ #
    
    autoload :TestHelpers,  'artisan_engine/attachability/test_helpers' if Rails.env.test?
    autoload :CanAttach,    'artisan_engine/attachability/can_attach'
    autoload :IsAttachable, 'artisan_engine/attachability/is_attachable'
    
    # ------------------------- Vroom vroom! ------------------------- #
    
    class Engine < Rails::Engine
      
      initializer 'extend ActiveRecord' do
        ActiveRecord::Base.class_eval { include ArtisanEngine::Attachability::CanAttach }
        ActiveRecord::Base.class_eval { include ArtisanEngine::Attachability::IsAttachable }
      end

    end

  end
end