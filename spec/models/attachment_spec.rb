require 'spec_helper'

# Proxy for an Attachment model.
describe Accessory do
  let( :accessory )      { Accessory.create! }
  let( :mr_potato_head ) { PotatoHead.create! }
  
  before do
    accessory.attach_to mr_potato_head
  end
  
  it "responds true when asked if it is an attachment" do
    accessory.is_attachment?.should be_true
  end
  
  context "before destroying: " do
    it "destroys all its related attachers" do
      accessory.destroy
      Attacher.count.should == 0
    end
  end
  
  describe "#attach_to" do
    context "caveats: " do
      it "will not attach to a non-attachable model" do
        non_attachable_model = Accessory.create!
      
        proc { 
          accessory.attach_to( non_attachable_model )
        }.should raise_error "Can't attach to a non-attachable model."
      end
      
      it "will not attach if it is a new record" do
        proc {
          Accessory.new.attach_to( mr_potato_head )
        }.should raise_error "Can't attach as or to a new record."
      end
      
      it "will not attach to a new record" do
        new_attachable = PotatoHead.new
        
        proc {
          accessory.attach_to( new_attachable )
        }.should raise_error "Can't attach as or to a new record."
      end
    end

    it "creates a new attacher between itself and the given attachable" do
      Attacher.where( "attachment_id = #{ accessory.id } AND attachable_id = #{ mr_potato_head.id }" ).first
              .should be_a Attacher
    end
  end
  
  describe "#attached" do
    let( :mrs_potato_head )     { PotatoHead.create! }
    let( :grandpa_potato_head ) { PotatoHead.create! }
    
    before do
      accessory.attach_to mrs_potato_head
      accessory.attach_to grandpa_potato_head
      
      grandpa_potato_head.attachers.where( :attachment_id => accessory.id ).first
                                   .usurp( :position => 1 )
    end
    
    context "when not given a scope" do
      it "returns all attached attachables in ascending order of attacher position" do
        accessory.attached.should == [ grandpa_potato_head, mr_potato_head, mrs_potato_head ]
      end
    end
    
    context "when given a scope" do
      it "returns all attached attachables in the scope in ascending order of attacher position" do
        accessory.attached( :potato_heads ).should == [ grandpa_potato_head, mr_potato_head, mrs_potato_head ]
      end
    end
  end
        
end