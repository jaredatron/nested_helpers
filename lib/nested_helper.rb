class NestedHelper
  
  def self.new(*)
    super.to_html
  end
  
  def initialize(parent, *args, &block)
    @called = []
    @parent = parent
    @args = args
    @block = block
    init_options(*args)
  end
  attr_reader :parent, :called, :block, :args
  attr_accessor :html_options, :partial_options
  
  def respond_to?(method)
    super or parent.respond_to?(method)
  end
  
  def name
    self.class.to_s.gsub(/^(?:.*::)?(\w+)$/,'\1')
  end

  private

  def method_missing(method, *args, &block)
    parent.send(method, *args, &block)
  end
  
  # overwrite this to handle the options passed to your helper
  def init_options(*args)
    @html_options = args.first || {}
    @partial_options = html_options.delete(:render)
  end
  
  def capture_block
    return nil if block.nil?
    self_recorded = SendRecorder.new(self)
    returning capture(self_recorded, &block) do
      @called = self_recorded.__called__ #.clone ??
    end
  end
  
  def render_partial
    return nil unless partial_options
    self_recorded = SendRecorder.new(self)
    partial_options[:locals] ||= {}
    partial_options[:locals][name.downcase.to_sym] = self_recorded
    partial_options[:locals][name.downcase[0,1].to_sym] = self_recorded
    returning render(partial_options) do
      @called = self_recorded.__called__ #.clone ??
    end
  end

  def captured_content
    @captured_content ||= capture_block or render_partial
  end
  
  # overwrite this to customize the rendering of your helper
  def to_html
    concat(captured_content)
  end

end