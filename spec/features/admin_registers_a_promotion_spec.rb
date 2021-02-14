require 'rails_helper'

feature 'Admin registers a promotion' do
  scenario 'from index page' do
    admin = Admin.create!(email: 'test@test.com', password: "password")
    sign_in admin

    visit root_path
    click_on 'Promoções'

    expect(page).to have_link('Registrar uma promoção',
                              href: new_promotion_path)
  end

  scenario 'successfully' do
    admin = Admin.create!(email: 'test@test.com', password: "password")
    sign_in admin
    
    visit root_path
    click_on 'Promoções'
    click_on 'Registrar uma promoção'

    fill_in 'Nome', with: 'Cyber Monday'
    fill_in 'Descrição', with: 'Promoção de Cyber Monday'
    fill_in 'Código', with: 'CYBER15'
    fill_in 'Desconto', with: '15'
    fill_in 'Quantidade de cupons', with: '90'
    fill_in 'Data de término', with: '22/12/2033'
    click_on 'Criar promoção'

    expect(current_path).to eq(promotion_path(Promotion.last))
    expect(page).to have_content('Cyber Monday')
    expect(page).to have_content('Promoção de Cyber Monday')
    expect(page).to have_content('15,00%')
    expect(page).to have_content('CYBER15')
    expect(page).to have_content('22/12/2033')
    expect(page).to have_content('90')
    expect(page).to have_content 'Criada por: test@test.com'
    expect(page).to have_link('Voltar')
  end

  scenario 'and choose categories' do
    Category.create!(name: 'Mouses', code: 'mouse')
    Category.create!(name: 'Jogos', code: 'jogo')
    Category.create!(name: 'Monitores', code: 'monitor')
    Category.create!(name: 'Teclados', code: 'teclado')

    admin = Admin.create!(email: 'test@test.com', password: "password")
    sign_in admin
    
    visit root_path
    click_on 'Promoções'
    click_on 'Registrar uma promoção'

    fill_in 'Nome', with: 'Cyber Monday'
    fill_in 'Descrição', with: 'Promoção de Cyber Monday'
    fill_in 'Código', with: 'CYBER15'
    fill_in 'Desconto', with: '15'
    fill_in 'Quantidade de cupons', with: '90'
    fill_in 'Data de término', with: '22/12/2033'

    check 'Mouses'
    check 'Jogos'
    check 'Monitores'

    click_on 'Criar promoção'

    expect(current_path).to eq(promotion_path(Promotion.last))
    expect(page).to have_content('Mouses')
    expect(page).to have_content('Jogos')
    expect(page).to have_content('Monitores')
    expect(page).to_not have_content('Teclados')
  end
end
