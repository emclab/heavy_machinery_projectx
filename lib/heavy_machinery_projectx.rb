require "heavy_machinery_projectx/engine"

module HeavyMachineryProjectx
  mattr_accessor :customer_class, :show_customer_path, :index_installation_path, :index_production_plan_path, :index_supplied_path, :index_sourced_path
  
  def self.customer_class
    @@customer_class.constantize
  end
end
