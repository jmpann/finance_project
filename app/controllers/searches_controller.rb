class SearchesController < ApplicationController

  skip_before_action :verify_authenticity_token



  def new
    @etf = Etf.find_by_ticker(etf_params)
    #explanation ||= if @etf = nil, then set @etf = Scraper.new_from_lookup
    #IE, if the ETF is not in the database, scrape for it.
    @etf ||= Scraper.new_from_lookup(etf_params)
    if @etf
      #only creates a valid search record if an ETF is found. Each search belongs to an etf so the search#index action can generate clickable links to each etf#show page.
      @search = Search.create(ticker: etf_params, user_id: current_user.id, etf_id: @etf.id)
    else
      flash[:danger] = "#{params[:etf]} could not be found"
    end
    redirect_to window_location
  end

  def index
    @user_searches = current_user.searches.order(created_at: :desc).limit(10)
  end

  def etf_params
   @etf_params ||= params[:etf].to_s.upcase
  end

  def window_location
    #rerender search page if the etf cannot be found in db or scraped.
   return etf_path(@etf) if @etf.present?

   search_path
  end
end
