class NestedHelper
  def initialize(parent, *args, &block)
    @called = []
    @parent = parent
    @args = args
    @block = block
    init_options(*args)
  end
  attr_reader :parent, :called, :block, :args
  
  def method_missing(method, *args, &block)
    parent.send(method, *args, &block)
  end
  
  def respond_to?(method)
    super or parent.respond_to?(method)
  end
  
  def capture_block
    self_recorder = SendRecorder.new(self)
    returning capture(self_recorder, &block) do
      @called = self_recorder.__called__ #.clone ??
    end
  end
  
  # overwrite this to hangle the options passed to your helper
  def init_options(*args)
  end
  
  # overwrite this to customize the rendering of your helper
  def render
    capture_block
  end
end