class NestedHelper::SendRecorder < BlankSlate
  def initialize(host)
    @__host__ = host
    @__called__ = []
  end
  attr_reader :__host__, :__called__

  def __called?(method)
    __called__.include? method.to_sym
  end

  def method_missing(method, *args, &block)
    __called__ << method
    __host__.send(method, *args, &block)
  end
end