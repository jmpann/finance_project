class EtfsController < ApplicationController

  def show
    @etf = Etf.find(params[:id])
    @top_holdings = @etf.top_holdings.order(amount: :desc)
    @country_weights = @etf.country_weights.order(amount: :desc)
    @sector_allocations = @etf.sector_allocations.order(amount: :desc)

    #this allows csv files to be downloaded by appending .csv to end of the URL. this happens when users click the download button on the show page. 
    respond_to do |format|
      format.html
      format.csv { send_data @etf.to_csv, filename: "etf-#{@etf.ticker.upcase}-#{Date.today}.csv" }
    end
  end

end
