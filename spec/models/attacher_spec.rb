require 'spec_helper'

describe Attacher do
  let( :new_attacher ) { Attacher.new :attachment => stub_model( PotatoHead ),
                                      :attachable => stub_model( Accessory ) }
  
  context "validations: " do
    it "is valid with valid attributes" do
      new_attacher.should be_valid
    end
    
    it "is not valid without an attachment" do
      new_attacher.attachment = nil
      new_attacher.should_not be_valid
    end
    
    it "is not valid without an attachable" do
      new_attacher.attachable = nil
      new_attacher.should_not be_valid
    end
    
    it "new attachers are not valid if a duplicate attacher exists" do
      attachable = Accessory.create!
      attachment = PotatoHead.create!
      
      existing_attacher  = Attacher.create! :attachable => attachable, 
                                            :attachment => attachment
      
      duplicate_attacher = Attacher.new :attachable => attachable, 
                                        :attachment => attachment
    
      duplicate_attacher.should_not be_valid
    end
  end

end