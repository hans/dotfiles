require 'rubygems'

class Object
  def local_methods
    p self.methods.sort - self.class.superclass.methods
  end
end
