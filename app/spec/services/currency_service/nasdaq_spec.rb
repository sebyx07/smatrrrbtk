require 'rails_helper'

describe CurrencyService::Nasdaq do
  describe '.get' do
    %w(30 365).each do |time_span|
      context time_span do
        it 'returns array of RESULTS' do
          result = CurrencyService::Nasdaq.get(time_span)
          expect(result).to be_a(Array)
          expect(result.size).to be > 0
        end
      end
    end
  end
end