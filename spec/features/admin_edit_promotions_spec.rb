require 'rails_helper'

feature 'Admin edit promotions' do
  scenario 'successfully' do
    Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                      code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                      expiration_date: '22/12/2033')
    Promotion.first.update!(name: 'Natal 2034', description: 'Promoção de Natal 2034', 
                            coupon_quantity: 34, code: 'NATAL34', discount_rate: 34, 
                            expiration_date: '22/12/2034')

    visit root_path
    click_on 'Promoções'

    expect(page).to have_content('Natal 2034')
    expect(page).to have_content('Promoção de Natal 2034')
    expect(page).to have_content(34)
    expect(page).to have_content('NATAL34')
    expect(page).to have_content('34,00%')
    expect(page).to have_content('22/12/2034')
  end

  scenario 'and attributes cannot be blank' do
    Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                      code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                      expiration_date: '22/12/2033')
  
    visit root_path
    click_on 'Promoções'
    click_on 'Editar promoção'
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Código', with: ''
    fill_in 'Desconto', with: ''
    fill_in 'Quantidade de cupons', with: ''
    fill_in 'Data de término', with: ''
    click_on 'Atualizar promoção'

    expect(page).to have_content('não pode ficar em branco', count: 5)
  end

  scenario 'and code must be unique' do
    Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                      code: 'NATAL50', discount_rate: 10, coupon_quantity: 100,
                      expiration_date: '22/12/2033')
    Promotion.create!(name: 'Natal2', description: 'Promoção de Natal',
                      code: 'NATAL59', discount_rate: 10, coupon_quantity: 100,
                      expiration_date: '22/12/2033')

    visit edit_promotion_path(Promotion.last)
    fill_in 'Código', with: 'NATAL50'
    click_on 'Atualizar promoção'

    expect(page).to have_content('deve ser único')
  end
end
