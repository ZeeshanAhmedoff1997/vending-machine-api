module Api::V1
  class ProductsController < BaseController
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
      product = current_user.products.new(doc_params)
    
      if product.save
        render json: serialize(product), status: :created
      else
        render json: product.errors, status: :unprocessable_entity
      end
    end

    def update
      if @product.update(product_params)
        render json: product, status: :ok
      else
        render json: product.errors, status: :unprocessable_entity
      end
    end

    def destroy
      if @product.destroy
        render json: product, status: :ok
      else
        render json: product.errors, status: :unprocessable_entity
      end
    end

    def user_products
      products = current_user.products

      render json: products, status: :ok
    end

    private
      def product_params
        params.require(:product).permit(:name, :quantity, :cost)
      end

      def set_product
        @product = current_user.products.find(params[:id])
      end
  end
end
