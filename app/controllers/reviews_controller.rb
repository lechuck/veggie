class ReviewsController < ApplicationController
  require 'restaurant_nested_resource'
  before_filter :find_restaurant
  before_filter :find_review, :except => [:new, :create]

  # GET /restaurants/:restaurant_id/reviews/new
  def new
    @review = Review.new
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

  private

  def find_review
    @review = Portion.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    logger.error "Attempt to access invalid portion #{params[:id]}"
    return redirect_to @restaurant, :notice => 'Invalid portion'
  end
end