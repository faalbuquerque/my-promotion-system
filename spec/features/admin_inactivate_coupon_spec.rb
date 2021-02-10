require 'rails_helper'

feature 'Admin inactivate coupons' do
  scenario 'successfully' do
    admin = Admin.create!(email: 'test@test.com', password: "password")
    sign_in admin

    promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                  code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                                  expiration_date: '22/12/2033', admin: admin)
    coupon = Coupon.create!(code: 'AAA-11', promotion: promotion)

    visit root_path
    click_on 'Promoções'
    click_on promotion.name
    click_on 'Inativar'
 
    coupon.reload
    expect(page).to  have_content('AAA-11(Inativo)')

    #expect(coupon).to be_inactive
    expect(coupon.inactive?).to be(true)
  end

  scenario 'do not view the button to activate coupons' do
    admin = Admin.create!(email: 'test@test.com', password: "password")
    sign_in admin
    
    promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                  code: 'NATAL10', discount_rate: 10, coupon_quantity: 2,
                                  expiration_date: '22/12/2033', admin: admin)
    inactive_coupon = Coupon.create!(code: 'ABC0001', promotion: promotion, status: :inactive)
    active_coupon = Coupon.create!(code: 'ABC0002', promotion: promotion, status: :active)

    visit root_path
    click_on 'Promoções'
    click_on promotion.name

    expect(page).to have_content('ABC0001(Inativo)')
    expect(page).to have_content('ABC0002(Ativo)')

    within("div#coupon-#{active_coupon.id}") do
      expect(page).to have_link 'Inativar'
    end

    within("div#coupon-#{inactive_coupon.id}") do
      expect(page).not_to have_link 'Inativar'
    end
  end
end
