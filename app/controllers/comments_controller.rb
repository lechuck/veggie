class CommentsController < ApplicationController
  load_and_authorize_resource :restaurant
  load_and_authorize_resource :through => :restaurant

  add_crumb("Ravintolat") { |instance| instance.send :restaurants_path }

  def new
    @comment = Comment.new
    add_crumb @restaurant.name, @restaurant
    add_crumb "uusi kommentti", nil
  end

  def create
    @comment = Comment.create(params[:comment])
    @comment.deleted = false
    @comment.user = current_user
    if (@restaurant.comments << @comment)
      flash[:notice] = "Kiitos kommentistasi." # for the js response
      respond_to do |format|
        format.html {redirect_to(@restaurant, :notice => "Kommenttisi lisättiin")}
        format.js
      end
    else
      render :action => "new"
    end
  end

  # does what destroy usually does
  def destroy
    @comment.destroy
    redirect_to @restaurant, :notice => "Kommentti on oikeasti poistettu"
  end

  # marks comment as deleted. doesn't remove anything from db.
  # only user him/herself or admins can mark messages as deleted.
  def delete
    @comment.deleted = true
    @comment.save
    respond_to do |format |
      format.html { redirect_to @restaurant, :notice => 'Kommentti on poistettu.'}
      format.js
    end
  end

end
