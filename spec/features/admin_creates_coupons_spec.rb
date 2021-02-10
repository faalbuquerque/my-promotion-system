require 'rails_helper'

feature 'Admin creates coupons' do

  scenario 'in a promotion' do
    admin = Admin.create!(email: 'test@test.com', password: "password")
    sign_in admin

    promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                  code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                                  expiration_date: '22/12/2033', admin: admin )

    visit root_path
    click_on 'Promoções'
    click_on promotion.name
    click_on 'Gerar cupons'

    expect(page).to have_current_path(promotion_path(promotion))
    expect(page).to have_content('Cupons gerados com sucesso!')
    expect(page).to have_content('NATAL10-0001')
    expect(page).to have_content('NATAL10-0002')
    expect(page).to have_content('NATAL10-0100')
    expect(page).to_not have_content('NATAL10-0101')
  end

  scenario 'do not view the button to generate coupons' do
    admin = Admin.create!(email: 'test@test.com', password: "password")
    sign_in admin
    
    promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                  code: 'NATAL10', discount_rate: 10, coupon_quantity: 2,
                                  expiration_date: '22/12/2033', admin: admin)

    #active_coupon = Coupon.create!(code: 'ABC', promotion: promotion, status: :active)
    active_coupon = promotion.coupons.create!

    visit promotion_path(promotion)

    expect(page).to_not have_link 'Gerar cupons'
  end
end
