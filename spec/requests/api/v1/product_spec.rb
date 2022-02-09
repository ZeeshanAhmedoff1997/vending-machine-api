require "rails_helper"
include ActionController::RespondWith

RSpec.describe "/api/v1/products", type: :request do
  let(:seller) { FactoryBot.create(:user, role: :seller) }
  let(:buyer) { FactoryBot.create(:user, role: :buyer) }
  let(:product) { FactoryBot.create(:product, user: seller) }


  describe "POST /buy" do
    before do 
      post buy_api_v1_product_path(product), params: { quantity: 1 }, headers: buyer.create_new_auth_token
    end

    context "when user has insufficent deposit" do
      it "returns insufficent deposit" do
        expect(response.body).to eq("{\"user\":[\"Your deposit is insufficient\"]}")
      end
    end

    context "when user has sufficent deposit" do
      let(:buyer) { FactoryBot.create(:user, :with_deposit, role: :buyer) }

      it "returns spent" do
        expect(JSON.parse(response.body)["spent"]).to eq(5)
      end

      it "returns change" do
        expect(JSON.parse(response.body)["change"]).to eq({"100"=>0, "50"=>0, "20"=>0, "10"=>0, "5"=>1})
      end

      it "returns product" do
        expect(JSON.parse(response.body)["product"]["id"]).to eq(product.id)
      end
    end
  end
end