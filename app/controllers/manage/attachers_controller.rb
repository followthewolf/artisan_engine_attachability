module Manage
  class AttachersController < Manage::BackController
    
    def sort
      attachable_class = params[ :attachable_type ]
      attachable_id    = params[ :attachable_id ]
      attachment_class = params[ :attachment_type ]
      attachment_sym   = params[ :attachment_type ].underscore.to_sym
            
      params[ attachment_sym ].each_with_index do |attachment_id, index|
      	Attacher.where( "attachable_type = '#{ attachable_class }' AND 
      	                 attachable_id   = #{ attachable_id }      AND
      	                 attachment_type = '#{ attachment_class }' AND
      	                 attachment_id   = #{ attachment_id }" )
      	.first.usurp( :position => index + 1 )
      end
      
      render :nothing => true
    end
    
  end
end