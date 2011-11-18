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