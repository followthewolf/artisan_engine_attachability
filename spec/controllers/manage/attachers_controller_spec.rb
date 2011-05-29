require 'spec_helper'

describe Manage::AttachersController do
  before do
    @mr_potato_head = PotatoHead.create!
    @tuxedo         = Accessory.create!
    @angry_eyes     = Accessory.create!
    @mustache       = Accessory.create!
    
    @tuxedo.attach_to     @mr_potato_head
    @angry_eyes.attach_to @mr_potato_head
    @mustache.attach_to   @mr_potato_head
  end
    
  it "updates the positions of the models passed to it" do
    post 'sort', :attachable_type => 'PotatoHead',
                 :attachable_id   => @mr_potato_head.id,
                 :attachment_type => 'Accessory',
                 :accessory       => [ "#{ @mustache.id }", 
                                       "#{ @angry_eyes.id }", 
                                       "#{ @tuxedo.id }" ]
    
    @mr_potato_head.attached.should == [ @mustache, @angry_eyes, @tuxedo ]
  end
end