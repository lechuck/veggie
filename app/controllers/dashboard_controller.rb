class DashboardController < ApplicationController
  # GET /dashboard
  # GET /dashboard.xml
  def index
    
    respond_to do |format|
      format.html # index.html.erb

    end
  end
end
