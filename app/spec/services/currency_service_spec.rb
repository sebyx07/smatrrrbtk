require 'rails_helper'

describe CurrencyService do
  describe 'get_currency' do
    context 'unknown currency' do
      it 'throws' do
        expect do
          CurrencyService.get_currency(:ron, '30')
        end.to raise_error CurrencyService::CurrencyErr
      end
    end

    context 'valid currencies' do
      ['btc'].each do |currency|
        it 'ok' do
          values = CurrencyService.get_currency(currency, '30')
          expect(values).not_to be_nil
        end
      end
    end
  end
end