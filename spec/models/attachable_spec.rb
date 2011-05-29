require 'spec_helper'

# Proxy for an Attachable model.
describe PotatoHead do
  let( :potato_head ) { PotatoHead.create! }
  let( :mustache )    { Accessory.create! }
  
  before do
    potato_head.attach mustache
  end
  
  it "responds true when asked if it is attachable" do
    potato_head.is_attachable?.should be_true
  end
  
  context "before destroying: " do
    it "destroys all its related attachers" do
      potato_head.destroy
      Attacher.count.should == 0
    end
  end
  
  describe "#attach" do
    context "caveats: " do
      it "will not attach a non-attachment model" do
        non_attachment_model = PotatoHead.create!
      
        lambda { 
          potato_head.attach( non_attachment_model )
        }.should raise_error "Can't attach a non-attachment model."
      end
    
      it "will not attach if it is a new record" do
        lambda {
          PotatoHead.new.attach( mustache )
        }.should raise_error "Can't attach as or to a new record."
      end
      
      it "will not attach to a new record" do
        new_attachment = Accessory.new
        
        lambda {
          potato_head.attach( new_attachment )
        }.should raise_error "Can't attach as or to a new record."
      end
    end
        
    it "creates a new attacher between itself and the given attachment" do
      Attacher.where( "attachment_id = #{ mustache.id } AND attachable_id = #{ potato_head.id }" ).first
              .should be_a Attacher
    end
  end
  
  describe "#attached" do
    let( :beard )      { Accessory.create! }
    let( :angry_eyes ) { Accessory.create! }
    
    before do
      potato_head.attach beard
      potato_head.attach angry_eyes
      
      angry_eyes.attachers.where( :attachable_id => potato_head.id ).first
                          .usurp( :position => 1 )
    end
    
    context "when not given a scope" do
      it "returns all attached attachments in ascending order of attacher position" do
        potato_head.attached.should == [ angry_eyes, mustache, beard ]
      end
    end
    
    context "when given a scope" do
      it "returns all attached attachments in the scope in ascending order of attacher position" do
        potato_head.attached( :accessories ).should == [ angry_eyes, mustache, beard ]
      end
    end
  end
end