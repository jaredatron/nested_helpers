= nested_helpers

http://github.com/deadlyicon/nested_helpers

== DESCRIPTION:

I't allows you to nest helpers

== FEATURES/PROBLEMS:

It's too useful

== SYNOPSIS:

Writing this:

  module PurpleBox
    define_nested_helper :purple_box do

      def init_options(options={})
        @options = options
        options[:class] = "purple box #{options[:class]}"
      end
      attr_accessor :options

      def render
        content_tag(:div, capture(self, &block), options)
      end
      
      define_nested_helper :top do
        def render
          content_tag(:div, capture(self, &block), {:class => 'top'})
        end
      end
      
    end
  end

Lets you do this:

  <%- purple_box :id => 'the_box' do |pb| -%>
    <h1>This is your box</h1>
    <%- pb.top do |top| -%>
      <small>and this is it's top</small>
    <%- end -%>
  <%- end -%>

Which gives you this:

  <div class="purple box " id="the_box">
    <h1>This is your box</h1>
    <div class="top">
      <small>and this is it's top</small>
    </div>
  </div>

== TODO:

  enable to children to know what parents they are being called you from

== REQUIREMENTS:

Rails 2.3.2

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
