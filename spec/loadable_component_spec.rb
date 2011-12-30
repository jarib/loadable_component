require 'spec_helper'

describe LoadableComponent do

  it "does nothing if component is already loaded" do
    DetonatingComponent.new.get.should be_instance_of(DetonatingComponent)
  end

  it "calls #load if the component is not already loaded" do
    ok = LoadsOk.new(true)
    ok.get.should be_instance_of(LoadsOk)

    ok.load_called?.should be_true
  end

  it "raises an error if calling load does not cause the component to load" do
    ok = LoadsOk.new(false)
    lambda { ok.get }.should raise_error(LoadableComponent::UnableToLoadComponent)
  end

end