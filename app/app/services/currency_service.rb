module CurrencyService
  RESULT = Struct.new(:date, :value)
  class HttpErr < Exception; end

  class << self
    def get_currency(currency, time_span)

    end
  end
end