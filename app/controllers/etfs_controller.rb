class EtfsController < ApplicationController

  def search
    if params[:etf]
      @etf = Etf.find_by_ticker(params[:etf])
      @etf ||= Scraper.new_from_lookup(params[:etf])
    end
    
    # if @etf
    #   #render json: @stock
    #   render partial: 'etf/lookup'
    # else
    #   render status: :not_found, nothing: true
    # end
  end

end
