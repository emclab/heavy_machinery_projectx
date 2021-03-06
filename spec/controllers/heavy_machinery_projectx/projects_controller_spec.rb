require 'spec_helper'

module HeavyMachineryProjectx
  describe ProjectsController do
    before(:each) do
      controller.should_receive(:require_signin)
      controller.should_receive(:require_employee)
    end
    before(:each) do
      @project_num_time_gen = FactoryGirl.create(:engine_config, :engine_name => 'heavy_machinery_projectx', :engine_version => nil, :argument_name => 'project_num_time_gen', :argument_value => ' HeavyMachineryProjectx::Project.last.nil? ? (Time.now.strftime("%Y%m%d") + "-"  + 112233.to_s + "-" + rand(100..999).to_s) :  (Time.now.strftime("%Y%m%d") + "-"  + (HeavyMachineryProjectx::Project.last.project_num.split("-")[-2].to_i + 555).to_s + "-" + rand(100..999).to_s)')
      @pagination_config = FactoryGirl.create(:engine_config, :engine_name => nil, :engine_version => nil, :argument_name => 'pagination', :argument_value => 30)
      z = FactoryGirl.create(:zone, :zone_name => 'hq')
      type = FactoryGirl.create(:group_type, :name => 'employee')
      ug = FactoryGirl.create(:sys_user_group, :user_group_name => 'ceo', :group_type_id => type.id, :zone_id => z.id)
      @role = FactoryGirl.create(:role_definition)
      ur = FactoryGirl.create(:user_role, :role_definition_id => @role.id)
      ul = FactoryGirl.build(:user_level, :sys_user_group_id => ug.id)
      @u = FactoryGirl.create(:user, :user_levels => [ul], :user_roles => [ur])
      @cust = FactoryGirl.create(:kustomerx_customer)
      
    end
      
    render_views
    
    describe "GET 'index'" do
      it "returns all projects for regular user" do
        user_access = FactoryGirl.create(:user_access, :action => 'index', :resource => 'heavy_machinery_projectx_projects', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "HeavyMachineryProjectx::Project.where(:cancelled => false).order('id')")        
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        qs = FactoryGirl.create(:heavy_machinery_projectx_project, :cancelled => false, :last_updated_by_id => @u.id)
        qs1 = FactoryGirl.create(:heavy_machinery_projectx_project, :cancelled => false, :last_updated_by_id => @u.id,  :project_num => '23444',  :name => 'newnew')
        get 'index' , {:use_route => :heavy_machinery_projectx}
        assigns(:projects).should =~ [qs, qs1]       
      end
      
      it "should return project for the project_type" do
        user_access = FactoryGirl.create(:user_access, :action => 'index', :resource => 'heavy_machinery_projectx_projects', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "HeavyMachineryProjectx::Project.where(:cancelled => false).order('id')")        
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        qs = FactoryGirl.create(:heavy_machinery_projectx_project, :cancelled => false, :last_updated_by_id => @u.id)
        qs1 = FactoryGirl.create(:heavy_machinery_projectx_project, :cancelled => true, :last_updated_by_id => @u.id,  :project_num => '4355556', :name => 'newnew')
        get 'index' , {:use_route => :heavy_machinery_projectx}
        assigns(:projects).should eq([qs])
      end
      
    end
  
    describe "GET 'new'" do
      
      it "returns http success" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource => 'heavy_machinery_projectx_projects', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")        
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        get 'new' , {:use_route => :heavy_machinery_projectx}
        response.should be_success
      end
           
    end
  
    describe "GET 'create'" do
      it "redirect for a successful creation" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource => 'heavy_machinery_projectx_projects', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")        
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        qs = FactoryGirl.attributes_for(:heavy_machinery_projectx_project)
        get 'create' , {:use_route => :heavy_machinery_projectx,  :project => qs}
        response.should redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Saved!")
      end
      
      it "should render 'new' if data error" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource => 'heavy_machinery_projectx_projects', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")        
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        qs = FactoryGirl.attributes_for(:heavy_machinery_projectx_project, :name => nil)
        get 'create' , {:use_route => :heavy_machinery_projectx,  :project => qs}
        response.should render_template("new")
      end
    end
  
    describe "GET 'edit'" do
      
      it "returns http success for edit" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource => 'heavy_machinery_projectx_projects', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")        
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        qs = FactoryGirl.create(:heavy_machinery_projectx_project, :customer_id => @cust.id)
        get 'edit' , {:use_route => :heavy_machinery_projectx,  :id => qs.id}
        response.should be_success
      end
      
    end
  
    describe "GET 'update'" do
      
      it "redirect if success" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource => 'heavy_machinery_projectx_projects', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")        
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        qs = FactoryGirl.create(:heavy_machinery_projectx_project)
        get 'update' , {:use_route => :heavy_machinery_projectx,  :id => qs.id, :project => {:name => 'newnew'}}
        response.should redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Updated!")
      end
      
      it "should render 'new' if data error" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource => 'heavy_machinery_projectx_projects', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")        
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        qs = FactoryGirl.create(:heavy_machinery_projectx_project)
        get 'update' , {:use_route => :heavy_machinery_projectx,  :id => qs.id, :project => {:name => nil}}
        response.should render_template("edit")
      end
    end
  
    describe "GET 'show'" do
      
      it "should show" do
        user_access = FactoryGirl.create(:user_access, :action => 'show', :resource => 'heavy_machinery_projectx_projects', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")        
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        qs = FactoryGirl.create(:heavy_machinery_projectx_project)
        get 'show' , {:use_route => :heavy_machinery_projectx,  :id => qs.id}
        response.should be_success
      end
    end
  end
end
