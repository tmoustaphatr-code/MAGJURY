class ProductsController < ApplicationController
# app/controllers/products_controller.rb
before_action :authenticate_user!
before_action :require_admin!, only: %i[new create edit update destroy]

before_action :set_product, only: %i[show edit update destroy]

layout 'dashboard', except: [:show]

def index
  @products = Product.includes(:product_category).order(created_at: :desc)
end

def new
  @product = Product.new
end

def create
  @product = Product.new(product_params)
  @post.user = current_user
  if @product.save
    redirect_to products_path, notice: "Produit créé."
  else
    render :new, status: :unprocessable_entity
  end
end

def show
  @product = Product.includes(:product_category).find(params[:id])
  @similar_products = Product.where(product_category: @product.product_category)
                             .where.not(id: @product.id)
                             .limit(3)
end

def edit

end

def update
  if @product.update(product_params)
    redirect_to products_path, notice: "Produit mis à jour."
  else
    render :edit, status: :unprocessable_entity
  end
end

def destroy
  @product.destroy
  redirect_to products_path, alert: "Produit supprimé."
end

private


  def set_product
    @product = Product.find(params[:id])
  end

  def require_admin!
    redirect_to root_path, alert: "Interdit." unless current_user.admin?
  end


def product_params
  params.require(:product).permit(:title, :description, :price, :reduced_price, :status, :stock, :product_category_id, :image)
end
end