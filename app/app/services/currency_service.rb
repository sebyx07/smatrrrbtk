module CurrencyService
  RESULT = Struct.new(:date, :value)
  class CurrencyErr < Exception; end
  CURRENCIES_CLASSES = {'btc' => CurrencyService::Btc,
                        'eth' => CurrencyService::Eth,
                        'nasdaq' => CurrencyService::Nasdaq}

  class << self
    def get_currency(currency, time_span)
      klass = CURRENCIES_CLASSES[currency]
      if klass.nil?
        raise CurrencyErr.new('currency not available')
      end

      klass.get(time_span)
    end

    def current_rates
      rates = {}
      rates['updated at'] = Time.now
      CURRENCIES_CLASSES.each.map do |key, klass|
        last_rate = klass.get('30').last.value
        rates[key] = last_rate
      end
      rates
    end
  end
end