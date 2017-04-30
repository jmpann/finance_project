class EtfsController < ApplicationController

  def search
    if params[:etf]
      @etf = Etf.find_by_ticker(params[:etf])
      @etf ||= Scraper.new_from_lookup(params[:etf])
    end
  end

  def show
    @etf = Etf.find(params[:id])
    @top_holdings = @etf.top_holdings
    @country_weights = @etf.country_weights
    @sector_allocations = @etf.sector_allocations
  end

end
