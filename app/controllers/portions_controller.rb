class PortionsController < ApplicationController
  before_filter :find_restaurant
  before_filter :find_portion, :except => [:new, :create]
  
  # GET /:restaurant_id/portions/new
  def new
    @portion = Portion.new
  end

  # GET /restaurants/:id/edit
  def edit
  end

  # POST /restaurants/:restaurant_id/portions
  def create
    @portion = Portion.new(params[:portion])
    if (@restaurant.portions << @portion)
      redirect_to @restaurant
    else
      render :action => :edit
    end
  end

  # PUT  /restaurants/:restaurant_id/portions/:id
  # PUT  /restaurants/:restaurant_id/portions/:id.xml
  def update    

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

  # DELETE /restaurants/:restaurant_id/portions/:id
  # DELETE /restaurants/:restaurant_id/portions/:id.xml
  def destroy
    @portion.destroy

    respond_to do |format|
      format.html { redirect_to @restaurant }
      format.xml  { head :ok }
    end
  end
  
  private
  def find_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  rescue ActiveRecord::RecordNotFound
    logger.error "Attempt to access invalid restaurant #{params[:restaurant_id]}"
    return redirect_to restaurants_path, :notice => 'Invalid restaurant'
  end

  def find_portion
    @portion = Portion.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    logger.error "Attempt to access invalid portion #{params[:id]}"
    return redirect_to @restaurant, :notice => 'Invalid portion'

  end
end
