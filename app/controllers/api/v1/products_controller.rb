module Api::V1
  class ProductsController < BaseController
    skip_before_action :authenticate_user!, only: [:index]
    before_action :set_product, only: [:update, :destroy]

    def index
      products = Product.all

      render json: products, status: :ok
    end

    def show
      product = Product.find(params[:id])

      render json: product, status: :ok
    end

    def create
      product = current_user.products.new(product_params)
    
      if product.save
        render json: product, status: :created
      else
        render json: product.errors, status: :unprocessable_entity
      end
    end

    def update
      if @product.update(product_params)
        render json: @product, status: :ok
      else
        render json: @product.errors, status: :unprocessable_entity
      end
    end

    def destroy
      if @product.destroy
        render json: @product, status: :ok
      else
        render json: @product.errors, status: :unprocessable_entity
      end
    end

    def user_products
      products = current_user.products

      render json: products, status: :ok
    end

    def buy
      trans = current_user.trans.new(product: Product.find(params[:id]), quantity: buy_params[:quantity])

      if trans.update(product_params)
        render json: trans, status: :ok
      else
        render json: trans.errors, status: :unprocessable_entity
      end
    end

    private
      def product_params
        params.permit(:name, :quantity, :cost)
      end

      def buy_params
        params.permit(:quantity)
      end

      def set_product
        @product = current_user.products.find(params[:id])
      end
  end
end
