require 'rails_helper'

feature 'Admin delete categories' do
  scenario 'successfully' do
    Category.create!(name: 'Eletronicos', code: '555')
    Category.create!(name: 'Portateis', code: '666')

    visit category_path(Category.last)
    click_on 'Apagar categoria'

    expect(page).to have_content('Eletronicos')
    expect(page).to have_content('555')

    expect(page).to_not have_content('Portateis')
    expect(page).to_not have_content('666')
  end
end
