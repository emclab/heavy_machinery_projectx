require "heavy_machinery_projectx/engine"

module HeavyMachineryProjectx
  mattr_accessor :customer_class, :show_customer_path
  
  def self.customer_class
    @@customer_class.constantize
  end
end
