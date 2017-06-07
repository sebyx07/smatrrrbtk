class CurrenciesController < ApplicationController
  def index
    @rates = CurrencyService.current_rates
  end

  def get_currency
    begin
      values = CurrencyService.get_currency(params[:currency], params[:time_span])
      render json: {data: values}
    rescue CurrencyService::CurrencyErr => e
      render json: {error: e.to_s}, status: 422
    end
  end
end
