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
    flash[:notice] = "Kiitos arvostelustasi." # for the js response
    if (@restaurant.ratings << @rating)
      find_restaurant_averages
      respond_to do |format|
        format.html {redirect_to(@restaurant, :notice => 'rating was successfully created.') }
        format.js {render 'update'}
      end
    else
      respond_to do |format|
        format.html{render :action => "new"}
        format.js {render 'error'}
      end
    end
  end

  # PUT /restaurants/:restaurant:id/ratings/:id
  def update
    if @rating.update_attributes(params[:rating])
      flash[:notice] = "Kiitos arvostelustasi." # for the js response
      find_restaurant_averages
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
    redirect_to @restaurant
  end

  private

  def find_restaurant_averages
    @food = @restaurant.average_rating_for :food
    @environment = @restaurant.average_rating_for :environment
    @service = @restaurant.average_rating_for :service
  end
  
end