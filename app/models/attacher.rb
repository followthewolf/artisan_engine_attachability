class Attacher < ActiveRecord::Base
  belongs_to :attachment, :polymorphic => true
  belongs_to :attachable, :polymorphic => true
  
  validates_presence_of :attachment, :attachable
  validate              :no_duplicate_attachers, :if => :new_record?
  
  has_listability
  
  private
  
    def no_duplicate_attachers
      if attachable and attachment
        duplicate_attacher = Attacher.where( "attachable_type = '#{ attachable_type }' AND
                                              attachable_id   = #{ attachable_id }   AND
                                              attachment_type = '#{ attachment_type }' AND
                                              attachment_id   = #{ attachment_id }" ).first
        
        errors.add :base, "Can't add a duplicate attacher." if duplicate_attacher
      end
    end
end