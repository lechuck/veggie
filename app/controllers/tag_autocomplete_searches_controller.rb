class TagAutocompleteSearchesController < ApplicationController
  
  respond_to :json
  
  def index
    #logger.info('no niin' + params[:term]);

    # Search the tags
    query = "SELECT name FROM tags"
    unless params[:term].nil?
      query = query + " WHERE name like '%" + params[:term] + "%'"
    
    end
    
    #@tags = Restaurant.connection.select_all("SELECT name FROM tags WHERE name like '%aw%'")    
    #@tags = Restaurant.connection.select_all("SELECT name FROM tags WHERE name like '%params[:term]%'").map{|x| x['name']}
    @tags = Restaurant.connection.select_all(query).map{|x| x['name']}
    @tags = @tags.to_json      
    
    #@alltags = %w(abc tag another blah)
    #@alltags = @alltags.to_json

     respond_to do |format|
       format.json  { render :json => @tags }       
     end
    
  end

end
