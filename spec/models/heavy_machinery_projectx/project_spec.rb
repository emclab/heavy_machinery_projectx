require 'rails_helper'

module HeavyMachineryProjectx
  RSpec.describe Project, type: :model do
    before(:each) do
      @project_num_time_gen = FactoryGirl.create(:engine_config, :engine_name => 'heavy_machinery_projectx', :engine_version => nil, :argument_name => 'project_num_time_gen',
      :argument_value => ' HeavyMachineryProjectx::Project.last.nil? ? (Time.now.strftime("%Y%m%d") + "-"  + 112233.to_s + "-" + rand(100..999).to_s) :  (Time.now.strftime("%Y%m%d") + "-"  + (HeavyMachineryProjectx::Project.last.project_num.split("-")[-2].to_i + 555).to_s + "-" + rand(100..999).to_s)')
     
    end
    it "should be OK" do
      c = FactoryGirl.build(:heavy_machinery_projectx_project)
      expect(c).to be_valid
    end
    
    it "should reject nil customer_id" do
      c = FactoryGirl.build(:heavy_machinery_projectx_project, :customer_id => nil)
      expect(c).not_to be_valid
   end
    
    it "should reject duplicate project name" do
      c0 = FactoryGirl.create(:heavy_machinery_projectx_project, :name => 'A name')
      c = FactoryGirl.build(:heavy_machinery_projectx_project, :name => 'a name')
      expect(c).not_to be_valid
    end
    
    it "should reject nil status_id" do
      c = FactoryGirl.build(:heavy_machinery_projectx_project, :status_id => nil)
      expect(c).not_to be_valid
    end
    
    it "should reject qty" do
      c = FactoryGirl.build(:heavy_machinery_projectx_project, :qty => nil)
      expect(c).not_to be_valid
    end
    
    it "should reject nil tech spec" do
      c = FactoryGirl.build(:heavy_machinery_projectx_project, :tech_spec => nil)
      expect(c).not_to be_valid
    end
    
    #it "should reject nil project_num" do
     # c = FactoryGirl.build(:heavy_machinery_projectx_project, :project_num => nil)
    #  expect(c).not_to be_valid
    #end
    
    it "should take nil category_id" do
      c = FactoryGirl.build(:heavy_machinery_projectx_project, :category_id => nil)
      expect(c).to be_valid
    end
    
    it "should reject 0 category_id" do
      c = FactoryGirl.build(:heavy_machinery_projectx_project, :category_id => 0)
      expect(c).not_to be_valid
    end
  end
end
