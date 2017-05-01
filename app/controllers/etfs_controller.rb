class EtfsController < ApplicationController

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
