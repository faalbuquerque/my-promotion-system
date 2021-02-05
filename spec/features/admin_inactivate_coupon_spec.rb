require 'rails_helper'


feature 'Admin inactivate coupons' do
  scenario 'successfully' do
    promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                      code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                      expiration_date: '22/12/2033')
    coupon = Coupon.create!(code: 'AAA-11', promotion: promotion)

    visit root_path
    click_on 'Promoções'
    click_on promotion.name
    click_on 'Inativar'

    expect(page).to  have_content('AAA-11 (Inativo)')
    
  
  end

end