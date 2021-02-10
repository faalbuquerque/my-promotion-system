require 'rails_helper'

describe Promotion do
  context 'validation' do
    it 'attributes cannot be blank' do
      admin = Admin.create!(email: 'test@test.com', password: "password")

      promotion = Promotion.new(name: '', description: '', code: '', 
                                discount_rate: '', coupon_quantity: '',
                                expiration_date: '', admin: admin)

      expect(promotion.valid?).to eq false
      expect(promotion.errors.count).to eq 5
    end

    it 'description is optional' do
      admin = Admin.create!(email: 'test@test.com', password: "password")
      promotion = Promotion.new(name: 'Natal', description: '', code: 'NAT',
                                coupon_quantity: 10, discount_rate: 10,
                                expiration_date: '2021-10-10', admin: admin)

      expect(promotion.valid?).to eq true
    end

    it 'error messages are in portuguese' do
      admin = Admin.create!(email: 'test@test.com', password: "password")
      sign_in admin
      promotion = Promotion.new

      promotion.valid?

      expect(promotion.errors[:name]).to include('não pode ficar em branco')
      expect(promotion.errors[:code]).to include('não pode ficar em branco')
      expect(promotion.errors[:discount_rate]).to include('não pode ficar em '\
                                                          'branco')
      expect(promotion.errors[:coupon_quantity]).to include('não pode ficar em'\
                                                            ' branco')
      expect(promotion.errors[:expiration_date]).to include('não pode ficar em'\
                                                            ' branco')
    end
  
    it 'code must be uniq' do
      admin = Admin.create!(email: 'test@test.com', password: "password")
      Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                        code: 'NATAL10', discount_rate: 10,
                        coupon_quantity: 100, expiration_date: '22/12/2033', admin: admin)
      promotion = Promotion.new(code: 'NATAL10')

      promotion.valid?

      expect(promotion.errors[:code]).to include('já está em uso')
    end
  end

  context '#create_coupons!' do
    it 'create coupons with a quantity' do
      admin = Admin.create!(email: 'test@test.com', password: "password")
      promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                    code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                                    expiration_date: '22/12/2033', admin: admin)

      promotion.create_coupons!

      expect(promotion.coupons.size).to eq 100
      codes = promotion.coupons.pluck(:code)
      expect(codes).to include('NATAL10-0001')
      expect(codes).to include('NATAL10-0100')
      expect(codes).to_not include('NATAL10-0101')
      expect(codes).to_not include('NATAL10-0000')
    end
    it 'do not create repeated codes' do
      admin = Admin.create!(email: 'test@test.com', password: "password")
      promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                    code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                                    expiration_date: '22/12/2033', admin: admin)
      promotion.coupons.create!(code: 'NATAL10-0030')

      expect { promotion.create_coupons! }.to raise_error(ActiveRecord::RecordInvalid)

      expect(promotion.coupons.reload.size).to eq(1)
    end
  end
end
