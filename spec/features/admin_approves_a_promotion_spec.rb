require 'rails_helper'

feature 'Admin approves a promotion' do
  scenario 'successfully' do
    creator = Admin.create!(email: 'creator@test.com', password: "p@ssword1")
    approval_admin = Admin.create!(email: 'approval@test.com', password: "passw0rd2")

    promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                  code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                                  expiration_date: '22/12/2033', admin: creator)

    sign_in approval_admin
    visit promotion_path(promotion)
    click_on 'Aprovar promoção'

    promotion.reload
    expect(current_path).to eq promotion_path(promotion)
    expect(promotion.approved?).to eq be_truthy
    expect(promotion.approver).to eq approval_admin

  end

  scenario 'must not be the promotion creator' do
    creator = Admin.create!(email: 'creator@test.com', password: "p@ssword1")

    promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                  code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                                  expiration_date: '22/12/2033', admin: creator)


    sign_in creator
    visit promotion_path(promotion)
    expect(page).to_not have_link 'Aprovar promoção'
  end

  scenario 'must be another user' do
    creator = Admin.create!(email: 'creator@test.com', password: "p@ssword1")
    approval_user = Admin.create!(email: 'other@test.com', password: "passw0rd2")

    promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                  code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                                  expiration_date: '22/12/2033', admin: creator)

    sign_in approval_user

    visit promotion_path(promotion)
    expect(page).to have_link 'Aprovar promoção'
  end
end