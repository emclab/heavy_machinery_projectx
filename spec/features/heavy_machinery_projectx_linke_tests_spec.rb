require 'rails_helper'

RSpec.describe "LinkeTests", type: :request do
  describe "GET /heavy_machinery_projectx_linke_tests" do
    mini_btn = 'btn btn-mini '
    ActionView::CompiledTemplates::BUTTONS_CLS =
        {'default' => 'btn',
         'mini-default' => mini_btn + 'btn',
         'action'       => 'btn btn-primary',
         'mini-action'  => mini_btn + 'btn btn-primary',
         'info'         => 'btn btn-info',
         'mini-info'    => mini_btn + 'btn btn-info',
         'success'      => 'btn btn-success',
         'mini-success' => mini_btn + 'btn btn-success',
         'warning'      => 'btn btn-warning',
         'mini-warning' => mini_btn + 'btn btn-warning',
         'danger'       => 'btn btn-danger',
         'mini-danger'  => mini_btn + 'btn btn-danger',
         'inverse'      => 'btn btn-inverse',
         'mini-inverse' => mini_btn + 'btn btn-inverse',
         'link'         => 'btn btn-link',
         'mini-link'    => mini_btn +  'btn btn-link',
         'left-span#'         => '6', 
               'offset#'         => '2',
               'form-span#'         => '4' 
        }
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
      
      ua1 = FactoryGirl.create(:user_access, :action => 'index', :resource => 'heavy_machinery_projectx_projects', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "HeavyMachineryProjectx::Project.where(:cancelled => false).order('id')")
      ua1 = FactoryGirl.create(:user_access, :action => 'create', :resource => 'heavy_machinery_projectx_projects', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "")
      ua1 = FactoryGirl.create(:user_access, :action => 'update', :resource => 'heavy_machinery_projectx_projects', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "record.last_updated_by_id == session[:user_id]")
      user_access = FactoryGirl.create(:user_access, :action => 'show', :resource =>'heavy_machinery_projectx_projects', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "record.last_updated_by_id == session[:user_id]")
      user_access = FactoryGirl.create(:user_access, :action => 'create_project', :resource => 'commonx_logs', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
      user_access = FactoryGirl.create(:user_access, :action => 'index_production_plan', :resource => 'event_taskx_event_tasks', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "EventTaskx::EventTask.where(:task_category => 'production_plan').order('id DESC')") 
        user_access = FactoryGirl.create(:user_access, :action => 'index_installation_plan', :resource => 'event_taskx_event_tasks', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "EventTaskx::EventTask.where(:task_category => 'installation_plan').order('id DESC')")  
      ua1 = FactoryGirl.create(:user_access, :action => 'index', :resource => 'sourced_partx_parts', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "SourcedPartx::Part") 
      ua1 = FactoryGirl.create(:user_access, :action => 'index', :resource => 'supplied_partx_parts', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "SuppliedPartx::Part")
      @cust = FactoryGirl.create(:kustomerx_customer)
      
      visit '/'
      #save_and_open_page
      fill_in "login", :with => @u.login
      fill_in "password", :with => 'password'
      click_button 'Login'
      
    end
    it "works! (now write some real specs)" do
      qs = FactoryGirl.create(:heavy_machinery_projectx_project, :cancelled => false, :last_updated_by_id => @u.id, :customer_id => @cust.id)
      visit heavy_machinery_projectx.projects_path(:customer_id => @cust.id)
      save_and_open_page
      expect(page).to have_content('Projects')
      click_link 'New Project'
      #save_and_open_page
      expect(page).to have_content('New Project')
      visit heavy_machinery_projectx.projects_path
      #save_and_open_page
      expect(page).to have_content('Projects')
      click_link 'New Project'
      #save_and_open_page
      expect(page).to have_content('New Project')
      visit heavy_machinery_projectx.projects_path
      click_link qs.id.to_s
      expect(page).to have_content('Project Info')
      click_link 'New Log'
      expect(page).to have_content('Log')
      #save_and_open_page
      visit heavy_machinery_projectx.projects_path() 
      save_and_open_page
      click_link 'Edit'
      #save_and_open_page
      expect(page).to have_content('Edit Project')
      
      
      visit heavy_machinery_projectx.projects_path(:customer_id => @cust.id)
      #save_and_open_page
      click_link('Purchasing')
      save_and_open_page
      
      visit heavy_machinery_projectx.projects_path(:customer_id => @cust.id)
      #save_and_open_page
      click_link('Sourcing')
      save_and_open_page
      
      visit heavy_machinery_projectx.projects_path(:customer_id => @cust.id)
      save_and_open_page
      click_link('Production Plans')
      #save_and_open_page
      
      visit heavy_machinery_projectx.projects_path(:customer_id => @cust.id)
      #save_and_open_page
      click_link('Installation Plans')
      #save_and_open_page
      
      
    end
  end
end
