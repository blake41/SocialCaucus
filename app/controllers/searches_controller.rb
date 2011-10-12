class SearchesController < ApplicationController
  
  def index
    
  end
  
  def create
    @results = Search.query(params)
    
    if params[:json]
      render :json => @results, :layout => false
    else
    end
  end
  
end
