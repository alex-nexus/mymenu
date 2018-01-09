ActiveAdmin.register Dish do
  scope_to :current_user, :association_method => :manage_restaurant_dishes
  menu :priority => 3
  filter :name
  filter :description

  config.sort_order = "name_asc"
  config.per_page = 20

  index :as => :grid do |dish|
    link_to(image_tag(dish.image_path), admin_dish_path(dish))
  end
end
