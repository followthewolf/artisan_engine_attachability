module ArtisanEngine
  module Attachability
    module IsAttachable
      def self.included( base )
        base.extend ClassMethods
      end
      
      module ClassMethods
        def is_attachable
          has_many :attachers, :as => :attachable, :dependent => :destroy
          
          include ArtisanEngine::Attachability::IsAttachable::InstanceMethods
        end
      end
      
      module InstanceMethods     
        def is_attachable?
          true
        end

        def attach( attachment )
          raise NoMethodError, "Can't attach a non-attachment model." unless attachment.respond_to? :is_attachment?
          raise StandardError, "Can't attach as or to a new record." if new_record? or attachment.new_record?

          attachers.create! :attachment => attachment
        end

        def attached( attachment_type = nil )
          if attachment_type
            attachers.in_position
                     .find_all_by_attachment_type( attachment_type.to_s.singularize.classify )
                     .map( &:attachment )
          else
            attachers.in_position.map( &:attachment )
          end
        end
      end
    end
  end
end