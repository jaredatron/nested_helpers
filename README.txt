= nested_helpers

http://github.com/deadlyicon/nested_helpers

== DESCRIPTION:

I't allows you to nest helpers

== FEATURES/PROBLEMS:

It's too useful

== SYNOPSIS:

Writing this:

  module WizrdHelper
  
    def wizard(html_options, &block)
      html_options[:class] = "wizard #{html_options[:class]}".strip
      haml_tag(div, capture(Wizard.new(self), &block), html_options)
    end
  
    class Wizard < NestedHelper
      def step(html_options, &block)
        html_options[:class] = "step #{html_options[:class]}".strip
        haml_tag(:div, capture(Step.new(self), &block), html_options)
      end
      
      class Step < NestedHelper
  
        def link_to_prev(html_options, &block)
          html_options.reverse_merge!(:href => 'javascript:void(null);', :class => 'prev_step')
          haml_tag(:a,html_options) do
            concat(capture(&block) || 'prev')
          end
        end
  
        def link_to_next(html_options, &block)
          html_options.reverse_merge!(:href => 'javascript:void(null);', :class => 'next_step')
          haml_tag(:a,html_options) do
            concat(capture(&block) || 'next')
          end
        end
  
        define_partial_proxy_helper :submit => 'wizard/submit'
  
      end
    end
  end


Lets you do this: (in haml)

   - form_for @user do |f|
     - wizard :id => "SignupWizard" do |w|
       - w.step :class => 'credentials' do
         = render :partial => 'static/homepage/signup_form/credentials', :locals => {:f => f}
       - w.step :class => 'gamer_info' do |w|
         - w.link_to_prev do
           back
         - w.link_to_next do
           Go!
         - w.submit
       - w.step :class => 'waiting'
         %h1
           Creating your new Rupture account...

== REQUIREMENTS:

Rails 2.3.2
Haml 2.2.2

== INSTALL:

sudo gem install deadlyicon-nested_helpers --source http://gems.github.com

== LICENSE:

(The MIT License)

Copyright (c) 2009 FIX

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
