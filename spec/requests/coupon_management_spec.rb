require 'rails_helper'

describe 'Coupon management' do
  context 'GET coupon' do

    it 'should render coupon information' do
      creator = Admin.create!(email: 'creator@test.com', password: "p@ssword1")
      promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                    code: 'NATAL10', discount_rate: 10, coupon_quantity: 1,
                                    expiration_date: '22/12/2033', admin: creator)
      promotion.create_coupons!
      coupon = promotion.coupons.last

      get "/api/v1/coupons/#{ coupon.code }"

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(200)
      expect(json_response[:status]).to eq('active')
      expect(json_response[:promotion][:discount_rate]).to eq('10.0')
    end

    it 'should return 404, coupon does not exist' do
      get "/api/v1/coupons/naoexiste"

      expect(response).to have_http_status :not_found
    end

  end
end
