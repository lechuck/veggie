# To change this template, choose Tools | Templates
# and open the template in the editor.

module RestaurantNestedResource
  def find_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  rescue ActiveRecord::RecordNotFound
    logger.error "Attempt to access invalid restaurant #{params[:restaurant_id]}"
    return redirect_to restaurants_path, :notice => 'Invalid restaurant'
  end
end
