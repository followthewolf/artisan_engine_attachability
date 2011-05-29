require 'spec_helper'

describe ArtisanEngine::Attachability do
  it "is an Engine" do
    ArtisanEngine::Attachability::Engine.ancestors.should include Rails::Engine
  end

  it "extends ActiveRecord::Base with the can_attach and is_attachable macro methods" do
    ActiveRecord::Base.should respond_to :can_attach
    ActiveRecord::Base.should respond_to :is_attachable
  end
end

describe "ArtisanEngine::Attachability Test/Development Environment" do
  it "initializes ArtisanEngine::Attachability" do
    ArtisanEngine::Attachability.should be_a Module
  end
  
  it "compiles its stylesheets into ArtisanEngine's stylesheets/artisan_engine/attachability directory" do
    Compass.configuration.css_path.should == "#{ ArtisanEngine.root }/lib/generators/artisan_engine/templates/assets/stylesheets/artisan_engine/attachability"
  end
  
  it "does not compile stylesheets during tests" do
    Sass::Plugin.options[ :never_update ].should be_true
  end
  
  it "compiles its javascripts into ArtisanEngine's javascripts/artisan_engine/attachability directory" do
    Barista.output_root.should == Pathname.new( "#{ ArtisanEngine.root }/lib/generators/artisan_engine/templates/assets/javascripts/artisan_engine/attachability" )
  end
end