module CurrencyService
  class Eth
    TIME_SPAN = {'30' => Proc.new { 30.days.ago.to_i * 1000}, '365' => Proc.new { 365.days.ago.to_i * 1000}}

    BASE_URL = Proc.new do
      "https://graphs.coinmarketcap.com/currencies/ethereum/TIME_SPAN/#{Time.now.to_i * 1000}/"
    end
    attr_reader :time_span

    def initialize(time_span)
      raise CurrencyService::CurrencyErr.new('Invalid Time Span') if TIME_SPAN[time_span].nil?
      @time_span = time_span
    end

    def get
      uri = URI(BASE_URL.call.gsub('TIME_SPAN', TIME_SPAN[time_span].call.to_s))
      response = Net::HTTP.get_response(uri)
      unless response.is_a?(Net::HTTPSuccess)
        raise CurrencyService::CurrencyErr.new('Server not available')
      end
      json = JSON.parse(response.body)
      json['price_usd'].map {|val| CurrencyService::RESULT.new(val[0] / 1000, val[1])}
    end

    class << self
      def get(time_span)
        new(time_span).get
      end
    end
  end
end