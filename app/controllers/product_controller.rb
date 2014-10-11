class ProductController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  add_breadcrumb "<span>//</span> Особистий кабінет".html_safe, :my_index_path

  def index
    add_breadcrumb "Їжа", :my_product_index_path
    @products = Product.all
  end

  def show
    add_breadcrumb "Їжа", :my_product_index_path
  end

  def new
    add_breadcrumb "Їжа", :my_product_index_path
    add_breadcrumb "Новий"
    @product = Product.new
  end

  def edit
    add_breadcrumb "Їжа", :my_product_index_path
    add_breadcrumb "Редагувати"
  end

  def create
    @product = Product.new(catalog_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to my_product_index_path, notice: 'Restoran was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @product.update(catalog_params)
        format.html { redirect_to my_product_index_url, notice: 'Restoran was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to my_product_index_url, notice: 'Restoran was successfully destroyed.' }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find_by_slug!(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def catalog_params
    params.require(:product).permit(:name, :slug, :price, :description, :point, :avatar, :category, :category_id, :category_attributes)
  end
end
