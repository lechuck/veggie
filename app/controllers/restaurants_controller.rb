class RestaurantsController < ApplicationController
  add_crumb("Restaurants") { |instance| instance.send :restaurants_path }  

  def like     
    if current_user 
      if not (Like.find(:first, :conditions => [ "restaurant_id = ?", params[:id]]))
        like = Like.new    
        like.user_id = current_user.id
        like.restaurant_id = params[:id]
        like.save
      end
    end
    #redirect_to dashboard_path
    redirect_to Restaurant.find(params[:id]) 
    
  end

  # GET /restaurants/1/add_tags
  def add_tags
    @restaurant = Restaurant.find(params[:id])
    @restaurant.tag_list << params[:taglist].split(",")
    @restaurant.save
    redirect_to @restaurant
    
  end
  
  def tag_cloud
    # refactor : Is this even needed anywhere?
    @tags = Restaurant.tag_counts_on(:tags)
    
  end

  def tag
    # Search all restaurants with tag
    @tag_name = params[:id]
    @restaurants_with_tag = Restaurant.tagged_with(@tag_name)
    #@restaurants_with_tag = r.find(:first)
      
  end
  
  # GET /restaurants
  # GET /restaurants.xml
  def index
    @restaurants = Restaurant.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @restaurants }
    end
  end

  # GET /restaurants/1
  # GET /restaurants/1.xml
  def show  
    @restaurant = Restaurant.find(params[:id])
    #@tags = Restaurant.tag_counts_on(:tags)
    @tags = Restaurant.find(@restaurant).tag_counts_on(:tags)
    @food = Review.where(:restaurant_id=>@restaurant).average("food")
    @environment = Review.where(:restaurant_id=>@restaurant).average("environment")
    @service = Review.where(:restaurant_id=>@restaurant).average("service")



    add_crumb @restaurant.name, @restaurant


    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @restaurant }
    end
  end

  # GET /restaurants/new
  # GET /restaurants/new.xml
  def new
    @restaurant = Restaurant.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @restaurant }
    end
  end

  # GET /restaurants/1/edit
  def edit
    @restaurant = Restaurant.find(params[:id])
    
    add_crumb @restaurant.name, @restaurant
    add_crumb "edit", nil    
  end

  # POST /restaurants
  # POST /restaurants.xml
  def create
    @restaurant = Restaurant.new(params[:restaurant])
    @restaurant.user = current_user

    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to(@restaurant, :notice => 'Restaurant was successfully created.') }
        format.xml  { render :xml => @restaurant, :status => :created, :location => @restaurant }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @restaurant.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /restaurants/1
  # PUT /restaurants/1.xml
  def update
    @restaurant = Restaurant.find(params[:id])

    respond_to do |format|
      if @restaurant.update_attributes(params[:restaurant])
        format.html { redirect_to(@restaurant, :notice => 'Restaurant was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @restaurant.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /restaurants/1
  # DELETE /restaurants/1.xml
  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy

    respond_to do |format|
      format.html { redirect_to(restaurants_url) }
      format.xml  { head :ok }
    end
  end
  
end
