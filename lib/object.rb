class Object
  # Creates a class inhereting from NestedHelper and defines a
  # method of the same name to instantiate and render that nested
  # helper
  def define_nested_helper(name, &block)
    name = name.to_s.downcase
    klass_name = name.classify
    const_set(klass_name.to_sym, Class.new(NestedHelper, &block))
    class_eval <<-CODE
      def #{name}(*args, &block)                       # def purple_box(*args, &block)
        #{klass_name}.new(self, *args, &block).render  #   PurpleBox.new(self, *args, &block).render
      end                                              # end
    CODE
  end
end