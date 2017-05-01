class SearchesController < ApplicationController

  def index
    @user_searches = current_user.searches.order(created_at: :desc).limit(10)
  end

  def new
    if params[:etf]
      @etf = Etf.find_by_ticker(params[:etf].upcase)
      @etf ||= Scraper.new_from_lookup(params[:etf].upcase)
    end

    if @etf.present?
      Search.create(ticker: params[:etf].upcase, user_id: current_user.id, status: "success" )
      render :js => "window.location = '#{etf_path(@etf)}'"
    else
      Search.create(ticker: params[:etf].upcase, user_id: current_user.id, status: "failure" )
      render :js => "window.location = '#{search_path}'"
      puts "error"
    end
  end
end
