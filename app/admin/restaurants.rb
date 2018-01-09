ActiveAdmin.register Restaurant do
  scope_to :current_user, :association_method => :manage_restaurants
  menu :priority => 1
  menu :if => proc{ current_user.has_role?(:overcomer) || current_user.manage_restaurants.count > 1}

  filter :name
  filter :description
  config.sort_order = "name_asc"
  config.per_page = 20

  index do
    selectable_column
    column "Name", :name, :sortable => :name
    column "Phone", :phone, :sortable => false
    column "Address", :address
    default_actions
  end
  
  # index :as => :blog do
    # title :name # Calls #my_title on each resource
    # body  :address  # Calls #my_body on each resource
  # end
  
  batch_action :approve, :priority => 1 do |selection|
    redirect_to collection_path, :alert => "Didn't really delete these!"
  end
  batch_action :disapprove, :priority => 2 do |selection|
    redirect_to collection_path, :alert => "Didn't really delete these!"
  end

  batch_action :destroy, :confirm => "Are you sure?" do |selection|
    redirect_to collection_path, :alert => "Didn't really delete these!"
  end
end
