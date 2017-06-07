module CurrencyService
  class Nasdaq
    TIME_SPAN = {'30' => Proc.new { 30.days.ago.to_i}, '365' => Proc.new { 365.days.ago.to_i}}

    BASE_URL = Proc.new do
      "https://l1-query.finance.yahoo.com/v8/finance/chart/%5EIXIC?period2=#{1496853493}&period1=TIME_SPAN&interval=1d&indicators=quote&includeTimestamps=true&includePrePost=true&events=div%7Csplit%7Cearn&corsDomain=finance.yahoo.com"
    end
    attr_reader :time_span

    def initialize(time_span)
      @time_span = time_span
    end

    def get
      uri = URI(BASE_URL.call.gsub('TIME_SPAN', TIME_SPAN[time_span].call.to_s))
      response = Net::HTTP.get_response(uri)
      unless response.is_a?(Net::HTTPSuccess)
        raise CurrencyService::CurrencyErr.new('Server not available')
      end
      json = JSON.parse(response.body)
      json['chart']['result'][0]['indicators']['quote'][0]['close'].each_with_index.map do |value, i|
        time_stamp = json['chart']['result'][0]['timestamp'][i]
        if value
          CurrencyService::RESULT.new(time_stamp, value)
        else
          nil
        end
      end.compact
    end

    class << self
      def get(time_span)
        new(time_span).get
      end
    end
  end
end