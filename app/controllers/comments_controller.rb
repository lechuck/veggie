class CommentsController < ApplicationController
  require 'restaurant_nested_resource'
  before_filter :find_restaurant, :except => [:delete, :destroy]
  before_filter :find_comment, :only => [:delete, :destroy]
  before_filter :check_login

  add_crumb("Restaurants") { |instance| instance.send :restaurants_path }

  
  def new
    @comment = Comment.new
    add_crumb @restaurant.name, @restaurant
    add_crumb "uusi kommentti", nil
  end

  def create
    @comment = Comment.create(params[:comment])
    @comment.user = current_user
    if (@restaurant.comments << @comment)
      redirect_to(@restaurant, :notice => "Kommenttisi lisättiin")
    else
      render :action => "new"
    end
  end

  # does what destroy usually does
  def destroy
    return redirect_to :back || user.admin?
    @comment.destroy
    redirect_to :back, :notice => "Kommentti on oikeasti poistettu"
  end

  # marks comment as deleted. doesn't remove anything from db.
  # only user him/herself or admins can mark messages as deleted.
  def delete
    unless current_user == @comment.user || current_user.admin?
      return redirect_to :back, :notice => "Vain viestin kirjoittanut käyttäjä tai ylläpitäjä voi poistaa viestin."
    end
    @comment.deleted = true
    @comment.save
    redirect_to :back, :notice => 'Kommentti on poistettu.'
  end

  private

  def find_comment
    @comment = Comment.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    logger.error "Attempt to access invalid portion #{params[:id]}"
    return redirect_to @restaurant, :notice => 'Invalid comment'
  end

  def check_login
    unless (current_user)
      return redirect_to :back, :notice => "Toiminto on vain sisäänkirjautuneille."
    end
  end

end
