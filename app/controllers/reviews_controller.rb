class ReviewsController < ApplicationController
  load_and_authorize_resource :restaurant
  load_and_authorize_resource :through => :restaurant

  add_crumb("Restaurants") { |instance| instance.send :restaurants_path }


  # GET /restaurants/:restaurant_id/reviews/new
  def new
    @review = Review.new
    add_crumb @restaurant.name, @restaurant
    add_crumb "new review", nil

  end

  # GET /restaurants/:restaurant:id/reviews/:id/edit
  def edit
  end

  # POST /restaurants/:restaurant:id/reviews
  def create
    @review = Review.new(params[:review])
    @review.user = current_user
    if (@restaurant.reviews << @review)
      redirect_to(@restaurant, :notice => 'Review was successfully created.')
    else
      render :action => "new"
    end
  end

  # PUT /restaurants/:restaurant:id/reviews/:id
  def update
    if @review.update_attributes(params[:review])
      redirect_to(@restaurant, :notice => 'Review was successfully updated.')
    else
      render :action => "edit"
    end
  end

  # DELETE /restaurants/:restaurant:id/reviews/:id
  def destroy
    @review.destroy
    redirect_to(reviews_url)
  end

end