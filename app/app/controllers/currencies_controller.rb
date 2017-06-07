class CurrenciesController < ApplicationController
  def index
    @rates = Rails.cache.fetch('current_rates', expires_in: 5.minutes) do
      CurrencyService.current_rates
    end
  end

  def get_currency
    begin
      values = Rails.cache.fetch("get_currency/#{params[:currency]}-#{params[:time_span]}", expires_in: 5.minutes) do
        CurrencyService.get_currency(params[:currency], params[:time_span])
      end
      render json: {data: values}
    rescue CurrencyService::CurrencyErr => e
      render json: {error: e.to_s}, status: 422
    end
  end
end
