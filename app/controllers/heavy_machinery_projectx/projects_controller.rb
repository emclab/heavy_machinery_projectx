require_dependency "heavy_machinery_projectx/application_controller"

module HeavyMachineryProjectx
  class ProjectsController < ApplicationController
    before_filter :require_employee
    before_filter :load_parent_record

    def index
      @title = t('Projects')
      @projects =  params[:heavy_machinery_projectx_projects][:model_ar_r]
      @projects = @projects.where(:customer_id => @customer.id) if @customer
      @projects = @projects.page(params[:page]).per_page(@max_pagination)
      @erb_code = find_config_const('project_index_view', 'heavy_machinery_projectx')
    end

    def new
      @title = t('New Project')
      @project = HeavyMachineryProjectx::Project.new
      @erb_code = find_config_const('project_new_view', 'heavy_machinery_projectx')
    end


    def create
      @project = HeavyMachineryProjectx::Project.new(params[:project], :as => :role_new)
      @project.last_updated_by_id = session[:user_id]
      if @project.save
        redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Saved!")
      else
        flash[:notice] = t('Data Error. Not Saved!')
        @erb_code = find_config_const('project_new_view', 'heavy_machinery_projectx')
        @customer = HeavyMachineryProjectx.customer_class.find_by_id(params[:project][:customer_id]) if params[:project].present? && params[:project][:customer_id].present?
        render 'new'
      end
    end

    def edit
      @title = t('Edit Project')
      @project = HeavyMachineryProjectx::Project.find_by_id(params[:id])
      @erb_code = find_config_const('project_edit_view', 'heavy_machinery_projectx')
    end

    def update
        @project = HeavyMachineryProjectx::Project.find_by_id(params[:id])
        @project.last_updated_by_id = session[:user_id]
        if @project.update_attributes(params[:project], :as => :role_update)
          redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Updated!")
        else
          flash[:notice] = t('Data Error. Not Updated!')
          @erb_code = find_config_const('project_edit_view', 'heavy_machinery_projectx')
          render 'edit'
        end
    end

    def show
      @title = t('Project Info')
      @project = HeavyMachineryProjectx::Project.find_by_id(params[:id])
      @erb_code = find_config_const('project_show_view', 'heavy_machinery_projectx')
    end
    
    protected
    def load_parent_record
      @customer = HeavyMachineryProjectx.customer_class.find_by_id(HeavyMachineryProjectx::Project.find_by_id(params[:id]).customer_id) if params[:id].present?
    end
  end
end
