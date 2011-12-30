require 'rspec'
require 'loadable_component'
require 'timecop'

class DetonatingComponent < LoadableComponent
  def load
    raise "should never be called"
  end

  def loaded?
    # already loaded
    true
  end
end

class LoadsOk < LoadableComponent
  def initialize(second_load_call_passes)
    @second_load_call_passes = second_load_call_passes
    @load_called = false
  end

  def load
    @load_called = true
  end

  def loaded?
    unless @load_called
      return false
    end

    unless @second_load_call_passes
      return false
    end

    true
  end

  def load_called?
    @load_called
  end
end

class SlowlyDetonatingComponent < SlowLoadableComponent
  def initialize
    super(1)
  end

  def load
    raise "should never be called"
  end

  def loaded?
    true
  end
end

class SlowLoading < SlowLoadableComponent
  attr_reader :load_called

  def initialize
    @load_called = false

    super(1)
  end

  def load
    @load_called = true
  end

  def loaded?
    @load_called
  end
end

class OnlyOneLoad < SlowLoading

  def load
    if @load_called
      raise "load already called"
    end

    super
  end
end

class BasicSlowLoader < SlowLoadableComponent
  def load
    # does nothing
  end

  def loaded?
    Timecop.travel 1
    false # never loads
  end
end

class HasError < SlowLoadableComponent
  class CustomError < StandardError; end

  def load
    # does nothing
  end

  def loaded?
    false
  end

  def check_error
    raise CustomError
  end
end