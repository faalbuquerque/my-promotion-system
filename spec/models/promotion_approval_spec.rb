require 'rails_helper'

RSpec.describe PromotionApproval, type: :model do
  describe '#valid?' do
    describe "different_admin" do
      it 'is different' do
        creator = Admin.create!(email: 'creator@test.com', password: "p@ssword1")
        approval_admin = Admin.create!(email: 'approval@test.com', password: "passw0rd2")

        promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                      code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                                      expiration_date: '22/12/2033', admin: creator)

        approval = PromotionApproval.new(promotion: promotion, admin: approval_admin)

        expect(approval.valid?).to eq true
      end

      it 'is the same' do
        creator = Admin.create!(email: 'creator@test.com', password: "p@ssword1")
        approval_admin = Admin.create!(email: 'approval@test.com', password: "passw0rd2")

        promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                      code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                                      expiration_date: '22/12/2033', admin: creator)

        approval = PromotionApproval.new(promotion: promotion, admin: creator)

        expect(approval.valid?).to eq false
      end

      it 'has no promotion or admin' do
        approval = PromotionApproval.new()

        expect(approval.valid?).to eq false
      end
    end
  end
end
