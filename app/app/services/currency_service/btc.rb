module CurrencyService
  class Btc
    TIME_SPAN = {'30' => '30days', '365' => '1year'}
    BASE_URL = 'https://api.blockchain.info/charts/market-price?cors=true&timespan=TIME_SPAN&format=json&lang=en'
    attr_reader :time_span

    def initialize(time_span)
      @time_span = time_span
    end

    def get
      uri = URI(BASE_URL.gsub('TIME_SPAN', TIME_SPAN[time_span]))
      response = Net::HTTP.get_response(uri)
      unless response.is_a?(Net::HTTPSuccess)
        raise CurrencyService::CurrencyErr.new('Server not available')
      end
      json = JSON.parse(response.body)
      json['values'].map {|val| CurrencyService::RESULT.new(val['x'], val['y'])}
    end

    class << self
      def get(time_span)
        new(time_span).get
      end
    end
  end
end