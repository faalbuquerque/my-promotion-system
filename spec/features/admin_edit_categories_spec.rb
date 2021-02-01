require 'rails_helper'

feature 'Admin edit categories' do
  scenario 'successfully' do
    Category.create!(name: 'Comida', code: 'comi100')
    Category.first.update!(name: 'Comida japonesa', code: 'comijapa')

    visit root_path
    click_on 'Promoções'

    expect(page).to_not have_content('Comida')
    expect(page).to_not have_content('comi100')
    expect(page).to have_content('Comida japonesa')
    expect(page).to have_content('comijapa')
  end

  scenario 'and attributes cannot be blank' do
    Category.create!(name: 'Bebida', code: 'bebi100')
  
    visit root_path
    click_on 'Categorias'
    click_on 'Editar categoria'
    fill_in 'Nome', with: ''
    fill_in 'Código', with: ''
    click_on 'Atualizar categoria'

    expect(page).to have_content('não pode ficar em branco', count: 2)
  end

  scenario 'and code must be unique' do
    Category.create!(name: 'Caes', code: 'caes10')
    Category.create!(name: 'Gatos', code: 'gatos10')

    visit edit_category_path(Category.last)
    fill_in 'Código', with: 'caes10'
    click_on 'Atualizar categoria'

    expect(page).to have_content('já está em uso')
  end
end
