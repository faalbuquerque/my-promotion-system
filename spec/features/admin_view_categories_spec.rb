require 'rails_helper'

feature 'Admin view categories' do
  scenario 'successfully' do
    Category.create!(name: 'Filmes de Suspense', code: 'FILMESS')
    Category.create!(name: 'Filmes de Medo', code: 'FILMESM', )

    visit root_path
    click_on 'Categorias'

    expect(page).to have_content('Filmes de Suspense')
    expect(page).to have_content('FILMESS')
    expect(page).to have_content('Filmes de Medo')
    expect(page).to have_content('FILMESM')
  end

  scenario 'and return to home page' do
    Category.create!(name: 'Games', code: 'games100')

    visit root_path
    click_on 'Categorias'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  scenario 'and view details' do
    Category.create!(name: 'Gatos', code: 'gatospeludos')
    Category.create!(name: 'Caes', code: 'Caesfofinhos')

    visit root_path
    click_on 'Categorias'
    click_on 'Gatos'

    expect(page).to have_content('Gatos')
    expect(page).to have_content('gatospeludos')
  end

  scenario 'and return to categories page' do
    Category.create!(name: 'Game of Thrones', code: 'GOT')

    visit root_path
    click_on 'Categorias'
    click_on 'Game of Thrones'
    click_on 'Voltar'

    expect(current_path).to eq categories_path
  end
end
