module ArtisanEngine
  module Attachability
    module CanAttach
      def self.included( base )
        base.extend ClassMethods
      end
      
      module ClassMethods
        def can_attach
          has_many :attachers, :as => :attachment, :dependent => :destroy
          
          include ArtisanEngine::Attachability::CanAttach::InstanceMethods
        end
      end
      
      module InstanceMethods
        def is_attachment?
          true
        end

        def attach_to( attachable )
          raise NoMethodError, "Can't attach to a non-attachable model." unless attachable.respond_to? :is_attachable?
          raise StandardError, "Can't attach as or to a new record." if new_record? or attachable.new_record?

          Attacher.create! :attachment => self, :attachable => attachable
        end

        def attached( attachable_type = nil )
          if attachable_type
            attachers.in_position
                     .find_all_by_attachable_type( attachable_type.to_s.singularize.classify )
                     .map( &:attachable )
          else
            attachers.in_position
                     .map( &:attachable )
          end
        end
      end
    end
  end
end