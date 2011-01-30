class RatingsController < ApplicationController
  load_and_authorize_resource :restaurant
  load_and_authorize_resource :through => :restaurant

  add_crumb("Restaurants") { |instance| instance.send :restaurants_path }


  # GET /restaurants/:restaurant_id/ratings/new
  def new
    add_crumb @restaurant.name, @restaurant
    add_crumb "Uusi arvostelu", nil

  end

  # GET /restaurants/:restaurant:id/ratings/:id/edit
  def edit
  end

  # POST /restaurants/:restaurant:id/ratings
  def create
    @rating.user = current_user
    if (@restaurant.ratings << @rating)
      respond_to do |format|
        format.html {redirect_to(@restaurant, :notice => 'rating was successfully created.') }
        format.js
      end
    else
      render :action => "new"
    end
  end

  # PUT /restaurants/:restaurant:id/ratings/:id
  def update
    if @rating.update_attributes(params[:rating])
      respond_to do |format|
        format.html {redirect_to(@restaurant, :notice => 'rating was successfully updated.')}
        format.js
      end
    else
      render :action => "edit"
    end
  end

  # DELETE /restaurants/:restaurant:id/ratings/:id
  def destroy
    @rating.destroy
    redirect_to(ratings_url)
  end

  private
  
end