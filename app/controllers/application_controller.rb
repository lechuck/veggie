class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to login_path, :notice => "Sinulla ei ollut tarvittavia oikeuksia toiminnon suorittamiseen."
  end


  protect_from_forgery
  add_crumb "Home", '/'
  
  helper_method :current_user
  before_filter :new_user_session
  before_filter :new_session
  
  def change_city
    logger.info 'change cityss::::::::::::::::::::::::::::::::::::'
    session[:city] = params[:city]
    respond_to do |format|
      format.html { redirect_to :back }
      format.js 
    end
  end
  
  private

  def new_session
    session[:city] = 'Helsinki' unless session[:city] # TODO: Better solution for default city
  end

  def new_user_session
    @user_session = UserSession.new
  end
    
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end
  
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end
  
end
