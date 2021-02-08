require 'rails_helper'

feature 'Admin registers a product category' do
  scenario 'and attributes cannot be blank' do
    admin = Admin.create!(email: 'test@test.com', password: "password")
    sign_in admin

    visit root_path
    click_on 'Categorias'
    click_on 'Registrar uma categoria'
    fill_in 'Nome', with: ''
    fill_in 'Código', with: ''
    click_on 'Criar categoria'

    expect(Category.count).to eq 0
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Código não pode ficar em branco')
  end

  scenario 'and code must be unique' do
    admin = Admin.create!(email: 'test@test.com', password: "password")
    sign_in admin
    
    Category.create!(name: 'Filmes', code: 'FILMES10')

    visit root_path
    click_on 'Categorias'
    click_on 'Registrar uma categoria'
    fill_in 'Código', with: 'FILMES10'
    click_on 'Criar categoria'

    expect(page).to have_content('já está em uso')
  end

end
