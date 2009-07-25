class NestedHelper

  def self.define_partial_proxy_helper(method_to_partial)
    method = method_to_partial.keys.first
    partial = method_to_partial.values.first
    class_eval <<-CODE
      def #{method.to_sym}(options={}, &block)                        # def red_slipper(*args, &block)
        body ||= capture(&block)  if block_given?                     # body ||= capture(&block)  if block_given?
        locals = {:options => options, :body => body}                 # locals = {:options => options, :body => body}
        concat( render(:partial => '#{partial}', :locals => locals))  # concat( render(:partial => 'shoes/red_slipper', :locals => locals))
      end                                                             # end
    CODE
  end
  
  def initialize(action_view)
    action_view = action_view.instance_variable_get('@action_view')  if action_view.is_a?(NestedHelper)
    action_view.is_a?(ActionView::Base)  or raise ArgumentError.new("the first argument to a nested helper must be an instance of ActionView::Base not #{action_view.class}")
    @action_view = action_view
  end
  
  def method_missing(method, *args, &block)
    @action_view.send(method, *args, &block)
  end

end