require 'rails_helper'

describe CurrenciesController, type: :controller do

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #get_currency' do
    context 'invalid currency' do
      it 'returns 422 and error' do
        post :get_currency, params: {currency: 'RON', time_span: '30'}
        expect(response).to have_http_status(422)
        expect(JSON.parse(response.body)['error']).not_to be_nil
      end
    end

    context 'valid currency' do
      it 'returns 200 and data' do
        post :get_currency, params: {currency: 'btc', time_span: '30'}
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['data']).not_to be_nil
      end
    end
  end
end
