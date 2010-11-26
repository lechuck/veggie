class PortionsController < ApplicationController
  before_filter :find_restaurant
  
  # GET /restaurants
  # GET /restaurants.xml
  def index
    redirect_to restaurants_url
  end

  # GET /restaurants/1
  # GET /restaurants/1.xml
  def show
  end

  # GET /restaurants/portions/new
  # GET /restaurants/portions/new.xml
  def new
   # @restaurant = Restaurant.find(params[:restaurant_id])
    @portion = Portion.new

  end

  # GET /restaurants/1/edit
  def edit
    @portion = Portion.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to restaurant_path(params[:restaurant_id], :notice => 'Oops. Portion not found.')
  end

  # POST /restaurants
  # POST /restaurants.xml
  def create
    @portion = Portion.new(params[:portion])
    #restaurant = Restaurant.find(params[:restaurant_id])
    if (@restaurant.portions << @portion)
      redirect_to @restaurant
    else
      render :action => :edit
    end
  end

  # PUT /restaurants/1
  # PUT /restaurants/1.xml
  def update
    @portion = Portion.find(params[:id])
    #restaurant = Restaurant.find(params[:restaurant_id])
    
    respond_to do |format|
      if @portion.update_attributes(params[:portion])
        format.html { redirect_to(@restaurant, :notice => 'Portion was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @portion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /restaurants/1
  # DELETE /restaurants/1.xml
  def destroy
    @portion = Portion.find(params[:id])
    @portion.destroy

    respond_to do |format|
      format.html { redirect_to(restaurants_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  def find_restaurant
    @restaurant_id = params[:restaurant_id]
    return(redirect_to restaurant_path) unless @restaurant_id
    @restaurant = Restaurant.find(@restaurant_id)
    
  end
end
