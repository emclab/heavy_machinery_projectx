module HeavyMachineryProjectx
  class Project < ActiveRecord::Base
    
    after_initialize :default_init, :if => :new_record?
    
    attr_accessor :awarded_noupdate, :cancelled_noupdate, :completed_noupdate, :customer_name, :category_name
    attr_accessible :awarded, :cancelled, :completed, :construction_requirement, :customer_id, :install_address, :last_updated_by_id, :name, :other_spec, 
                    :project_manager_id, :status_id, :tech_spec, :turn_over_requirement, :design_start_date, :production_start_date, :install_start_date,
                    :test_run_date, :turn_over_date, :bid_doc_available_date, :bid_deadline, :tender_open_date, :qty, :project_num, :category_id,
                    :customer_name,
                    :as => :role_new
    attr_accessible :awarded, :cancelled, :completed, :construction_requirement, :customer_id, :install_address, :last_updated_by_id, :name, :other_spec, 
                    :project_manager_id, :status_id, :tech_spec, :turn_over_requirement, :design_start_date, :production_start_date, :install_start_date,
                    :test_run_date, :turn_over_date, :bid_doc_available_date, :bid_deadline, :tender_open_date, :qty, :category_id,
                    :awarded_noupdate, :cancelled_noupdate, :completed_noupdate, :customer_name, :project_num,
                    :as => :role_update  
    
    attr_accessor :project_id_s, :keyword_s, :start_date_s, :end_date_s, :customer_id_s, :status_s, :expedite_s, :cancelled_s, :completed_s,
                  :zone_id_s, :sales_id_s, :project_task_template_id_s, :category_id_s, 
                  :time_frame_s

    attr_accessible :project_id_s, :keyword_s, :start_date_s, :end_date_s, :customer_id_s, :status_s, :expedite_s, :cancelled_s, :completed_s,
                    :zone_id_s, :sales_id_s, :project_task_template_id_s, :time_frame_s, :category_id_s, 
                    :as => :role_search_stats

                    
    belongs_to :status, :class_name => 'Commonx::MiscDefinition'
    belongs_to :category, :class_name => 'Commonx::MiscDefinition'
    belongs_to :customer, :class_name => HeavyMachineryProjectx.customer_class.to_s
    belongs_to :last_updated_by, :class_name => 'Authentify::User'
    belongs_to :project_manager, :class_name => 'Authentify::User'
    
    validates :name, :presence => true,
                     :uniqueness => {:case_sensitive => false, :message => I18n.t('Duplicate Name!')}
    validates_presence_of :tech_spec, :project_num 
    validates :customer_id, :status_id, :qty, :presence => true,
                                 :numericality => {:greater_than => 0, :only_integer => true} 
    validates :category_id, :numericality => {:greater_than => 0, :only_integer => true}, :if => 'category_id.present?'
    
    def default_init
      project_num_time_gen = Authentify::AuthentifyUtility.find_config_const('project_num_time_gen', 'heavy_machinery_projectx')
      self.project_num = eval(project_num_time_gen)
    end
    
    def customer_name_autocomplete
      self.customer.try(:name)
    end

    def customer_name_autocomplete=(name)
      self.customer = HeavyMachineryProjectx.customer_class.find_by_name(name) if name.present?
    end          
                    
  end
end
