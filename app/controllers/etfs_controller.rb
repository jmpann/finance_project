class EtfsController < ApplicationController

  def search
    if params[:etf]
      @etf = Etf.find_by_ticker(params[:etf])
      @etf ||= Scraper.new_from_lookup(params[:etf])
    end
    if @etf.present?
      path =
      render :js => "window.location = '#{etf_path(@etf)}'"
    else

    end
  end

  def show
    @etf = Etf.find(params[:id])
    @top_holdings = @etf.top_holdings.order(amount: :desc)
    @country_weights = @etf.country_weights.order(amount: :desc)
    @sector_allocations = @etf.sector_allocations.order(amount: :desc)

    respond_to do |format|
      format.html
      format.csv { send_data @etf.to_csv, filename: "etf-#{@etf.ticker}-#{Date.today}.csv" }
    end
  end

end
