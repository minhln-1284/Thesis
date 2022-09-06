require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order){ FactoryBot.create :order }

  describe "delegations" do
    it { should delegate_method(:name).to(:user) }
  end

  describe "enums" do
    it { should define_enum_for(:status) }
  end

  describe "associations" do
    it { should belong_to(:user) }
    it { should have_many(:order_details).dependent(:destroy)}
    it { should have_many(:products).through(:order_details) }
  end

  describe "check scope" do
    let!(:user){ FactoryBot.create :user }
    let!(:order){ FactoryBot.create(:order, user: user, status: 2) }

    it "created in this month" do
      expect(Order.this_month).to eq([order])
    end

    it "has the most order" do
      expect(Order.most_order).to eq(user.id)
    end
  end

  describe "check private method" do
    let(:product){ FactoryBot.create :product }
    let(:order){ FactoryBot.create(:order, status: 1) }
    let(:order_details){ OrderDetail.create(:order_details, status: 1, order: order) }
    let(:order_1){ FactoryBot.create(:order, status: 3) }
    let(:order_details_1){ OrderDetail.create(:order_details, status: 1, order: order_1) }

    it "check first case branch" do
      expect(order.save).to eq(true)
    end

    it "check second case branch" do
      expect(order_1.save).to eq(true)
    end
  end
end
