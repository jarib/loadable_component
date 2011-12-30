require "loadable_component/version"

#
# Read more about LoadableComponent here:
#
#   http://code.google.com/p/selenium/wiki/LoadableComponent
#

class LoadableComponent

  class UnableToLoadComponent < StandardError; end
  class SubclassResponsibility < StandardError; end

  def load
    raise SubclassResponsibility, "should implement #load"
  end

  def loaded?
    raise SubclassResponsibility, "should implement #loaded?"
  end

  def get
    load unless loaded?

    unless loaded?
      raise UnableToLoadComponent, unable_to_load_message
    end

    self
  end

  private

  def unable_to_load_message
    "could not load #{self.class.name}"
  end

end

class SlowLoadableComponent < LoadableComponent
  def initialize(timeout)
    @timeout = timeout
  end

  def get
    if loaded?
      return self
    end

    end_time = Time.now + @timeout
    until Time.now >= end_time
      return self if loaded?
      check_error
      sleep sleep_interval
    end

    unless loaded?
      raise UnableToLoadComponent, unable_to_load_message
    end

    self
  end

  #
  # Override this method to check for well-known error cases, which
  # means loading has finished, but an error condition was seen.
  #

  def check_error
    # no-op by default
  end

  def sleep_interval
    0.2
  end

  def unable_to_load_message
    "#{super} after #{@timeout} seconds"
  end
end