require 'rails_helper'

feature 'Admin search for promotion and coupons' do
  scenario 'successfully' do
    admin = Admin.create!(email: 'test@test.com', password: "password")
    sign_in admin

    promotion_natal = Promotion.create!(name: 'Natal 2020', description: 'Promoção de Natal',
                                        code: 'NATAL20', discount_rate: 5, coupon_quantity: 10, expiration_date: '22/12/2031', admin: admin)
    promotion_ano = Promotion.create!(name: 'Ano novo', description: 'Promoção de Ano novo',
                                      code: 'ANONOVO', discount_rate: 15, coupon_quantity: 30,
                                      expiration_date: '22/12/2033', admin: admin)

    Coupon.create!(code: 'NATAL-20', promotion: promotion_natal)
    Coupon.create!(code: 'NOVO-20', promotion: promotion_ano)

    visit root_path
    click_on 'Promoções'

    fill_in 'Buscar', with: 'natal'
    click_on 'Pesquisar'

    expect(current_path).to eq search_path
    expect(page).to have_content('Natal')
    expect(page).to_not have_content('Ano novo')
  end

  scenario 'result not found' do
    admin = Admin.create!(email: 'test@test.com', password: "password")
    sign_in admin

    promotion_natal21 = Promotion.create!(name: 'Natal 2021', coupon_quantity: 20,
                                          description: 'Promoção de Natal de novo',
                                          code: 'NATAL21', discount_rate: 10,
                                          expiration_date: '22/12/2032', admin: admin)
    promotion_ano_novo = Promotion.create!(name: 'Ano novo', description:'Anonovo'
                                           code:'ANONOVO', discount_rate: 15,
                                           coupon_quantity: 30, expiration_date: '22/12/2033', admin: admin)

    Coupon.create!(code: 'NATAL21', promotion: promotion_natal21)
    Coupon.create!(code: 'ANONOVO', promotion: promotion_ano_novo)

    visit root_path
    click_on 'Promoções'

    fill_in 'Buscar', with: 'Cachorro'
    click_on 'Pesquisar'

    expect(current_path).to eq search_path
    expect(page).to have_content('Nenhum resultado encontrado!')
    expect(page).to_not have_content('Natal')
    expect(page).to_not have_content('Ano novo')
  end
end
