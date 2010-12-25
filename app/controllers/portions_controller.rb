class PortionsController < ApplicationController
  require 'restaurant_nested_resource'

  before_filter :find_restaurant
  before_filter :find_portion, :except => [:new, :create]

  add_crumb("Restaurants") { |instance| instance.send :restaurants_path }  
  
  # GET /:restaurant_id/portions/new
  def new
    @portion = Portion.new
    add_crumb @restaurant.name, @restaurant
    add_crumb "new portion", nil
  end

  # GET /restaurants/:id/edit
  def edit
  end

  # POST /restaurants/:restaurant_id/portions
  def create
    @portion = Portion.new(params[:portion])
    @portion.user = current_user
                
    if (@restaurant.portions << @portion)
      redirect_to(@restaurant, :notice => "Portion was succesfully created")
    else
      render :action => "new"
    end
  end

  # PUT  /restaurants/:restaurant_id/portions/:id
  def update    
    if @portion.update_attributes(params[:portion])
      redirect_to(@restaurant, :notice => 'Portion was successfully updated.')
    else
      render :action => "edit"
    end
  end

  # DELETE /restaurants/:restaurant_id/portions/:id
  # DELETE /restaurants/:restaurant_id/portions/:id.xml
  def destroy
    @portion.destroy

    respond_to do |format|
      format.html { redirect_to @restaurant }
      format.xml  { head :ok }
    end
  end
  
  def find_portion
    @portion = Portion.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    logger.error "Attempt to access invalid portion #{params[:id]}"
    return redirect_to @restaurant, :notice => 'Invalid portion'
  end
end
