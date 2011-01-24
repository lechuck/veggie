class TagAutocompleteSearchesController < ApplicationController
  
  respond_to :json
  
  def Index
    @alltags = %w(abc tag another blah)
    @alltags = @alltags.to_json
    respond_with(@alltags)
    
  end

end
