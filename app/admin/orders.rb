ActiveAdmin.register Order do
  scope_to :current_user
  menu :priority => 4
  
end
