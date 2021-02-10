require 'rails_helper'

feature 'Admin in the application' do

  scenario 'register' do
    visit root_path
    click_on 'Login'
    click_on 'Sign up'

    fill_in 'E-mail', with: 'test@test.com'
    fill_in 'Senha', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_on 'Sign up'

    expect(page).to have_content('test@test.com')
    expect(page).to have_content('Promoções')
  end

  scenario 'login successfully' do
    admin = Admin.create!(email: 'test@test.com', password: "password")

    visit root_path
    click_on 'Login'

    fill_in 'E-mail', with: 'test@test.com'
    fill_in 'Senha', with: 'password'
    click_on 'Log in'

    expect(page).to have_content(admin.email)
    expect(page).to have_content('Logout')
  end

  scenario 'logout successfully' do
    admin = Admin.create!(email: 'test@test.com', password: "password")

    visit root_path
    click_on 'Login'

    fill_in 'E-mail', with: 'test@test.com'
    fill_in 'Senha', with: 'password'
    click_on 'Log in'
    click_on 'Logout'

    expect(page).to_not have_content(admin.email)
    expect(page).to have_content('Login')
  end
end
