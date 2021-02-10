require 'rails_helper'

feature 'Admin delete promotions' do
  scenario 'successfully' do
    admin = Admin.create!(email: 'test@test.com', password: "password")
    sign_in admin
    
    Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                      code: 'NATAL50', discount_rate: 10, coupon_quantity: 100,
                      expiration_date: '22/12/2033', admin: admin)
    Promotion.create!(name: 'Natal1', description: 'Promoção de Natal1',
                      code: 'NATAL501', discount_rate: 101, coupon_quantity: 1001,
                      expiration_date: '22/12/2031', admin: admin)

    visit promotion_path(Promotion.last)
    click_on 'Apagar promoção'

    expect(page).to have_content('Natal')
    expect(page).to have_content('Promoção de Natal')
    expect(page).to have_content('NATAL50')
    expect(page).to have_content('10,00%')
    expect(page).to have_content('100')
    expect(page).to have_content('22/12/2033')

    expect(page).to_not have_content('Natal1')
    expect(page).to_not have_content('Promoção de Natal1')
    expect(page).to_not have_content('NATAL501')
    expect(page).to_not have_content('101,00%')
    expect(page).to_not have_content('1001')
    expect(page).to_not have_content('22/12/2031')
  end
end
