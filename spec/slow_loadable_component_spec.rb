require 'spec_helper'

describe SlowLoadableComponent do

  it "does nothing if component is already loaded" do
    SlowlyDetonatingComponent.new.get.should be_instance_of(SlowlyDetonatingComponent)
  end

  it "calls #load if the component is not already loaded" do
    component = SlowLoading.new.get
    component.should be_instance_of(SlowLoading)

    component.load_called.should be_true
  end

  it "calls the load method once if the component takes a long time to load" do
    OnlyOneLoad.new.get
  end

  it "should throw an error if calling load does not cause the component to load before timeout" do
    lambda { BasicSlowLoader.new(1).get }.should raise_error(LoadableComponent::UnableToLoadComponent, /after 1 seconds/)
  end

  it "should cancel loading if an error is detected" do
    lambda { HasError.new(1).get }.should raise_error(HasError::CustomError)
  end

end
