module CurrencyService
  RESULT = Struct.new(:date, :value)
  class CurrencyErr < Exception; end
  CURRENCIES_CLASSES = {'btc' => CurrencyService::Btc}

  class << self
    def get_currency(currency, time_span)
      klass = CURRENCIES_CLASSES[currency]
      if klass.nil?
        raise CurrencyErr.new('currency not available')
      end

      klass.get(time_span)
    end
  end
end