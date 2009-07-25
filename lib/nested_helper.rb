#  Nested Helper
#
#
#     module WizrdHelper
#       class Wizard < NestedHelper
#         def step(html_options, &block)
#           html_options[:class] = "step #{html_options[:class]}".strip
#           haml_tag(:div, capture(Step.new(self), &block), html_options)
#         end
#         
#         class Step < NestedHelper
#
#           def link_to_prev(html_options, &block)
#             html_options.reverse_merge!(:href => 'javascript:void(null);', :class => 'prev_step')
#             haml_tag(:a,html_options) do
#               concat(capture(&block) || 'prev')
#             end
#           end
#
#           def link_to_next(html_options, &block)
#             html_options.reverse_merge!(:href => 'javascript:void(null);', :class => 'next_step')
#             haml_tag(:a,html_options) do
#               concat(capture(&block) || 'next')
#             end
#           end
#
#           define_partial_proxy_helper :submit => 'wizard/submit'
#
#         end
#       end
#     end
#
#
#
#    - form_for @user do |f|
#      - wizard :id => "SignupWizard" do |w|
#        - w.step :class => 'credentials' do
#          = render :partial => 'static/homepage/signup_form/credentials', :locals => {:f => f}
#        - w.step :class => 'gamer_info' do |w|
#          - w.link_to_prev do
#            back
#          - w.link_to_next do
#            Go!
#          - w.submit
#        - w.step :class => 'waiting'
#          %h1
#            Creating your new Rupture account...
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