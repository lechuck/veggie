class TagAutocompleteSearchesController < ApplicationController
  
  respond_to :json
  
  def index

    @tags = ''
    
    # Search the tags
    unless params[:term].nil?

      word_index = params[:term].rindex(',')
      if word_index.nil?
        word = params[:term]
      else 
        word = params[:term][word_index+1, params[:term].length]

      end

      word = word.strip
      
      logger.info('hehe:' + word)
      
      query = "SELECT name FROM tags"
      query = query + " WHERE name like '%" + word + "%'"

      @tags = Restaurant.connection.select_all(query).map{|x| x['name']}
    
    end
      
    @tags = @tags.to_json      

     respond_to do |format|
       format.json  { render :json => @tags }       
     end
    
  end

end
