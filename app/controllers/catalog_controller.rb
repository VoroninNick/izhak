class CatalogController < ApplicationController
  before_action :authenticate_user!
  before_action :get_admin
  before_action :set_catalog, only: [:show, :edit, :update, :destroy]

  add_breadcrumb "<span>//</span> Особистий кабінет".html_safe, :my_index_path

  def index
    add_breadcrumb "Каталог їжі", :my_catalog_index_path
    @catalogs = Category.all
  end

  def show
    add_breadcrumb "Каталог їжі", :my_catalog_index_path
  end

  def new
    add_breadcrumb "Каталог їжі", :my_catalog_index_path
    add_breadcrumb "Новий"
    @catalog = Category.new
  end

  def edit
    add_breadcrumb "Каталог їжі", :my_catalog_index_path
    add_breadcrumb "Редагувати"
  end

  def create
    @catalog = Category.new(catalog_params)

    respond_to do |format|
      if @catalog.save
        format.html { redirect_to my_catalog_index_path, notice: 'Restoran was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @catalog.update(catalog_params)
        format.html { redirect_to my_catalog_index_url, notice: 'Restoran was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @catalog.destroy
    respond_to do |format|
      format.html { redirect_to my_catalog_index_url, notice: 'Restoran was successfully destroyed.' }
    end
  end

  private

  def get_admin
    unless current_user.admin? || current_user.order_manager?
      redirect_to my_index_path, :notice => "Access denied."
    end
  end


  # Use callbacks to share common setup or constraints between actions.
  def set_catalog
    @catalog = Category.find_by_slug!(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def catalog_params
    params.require(:category).permit(:name, :slug, :restoran, :restoran_id)
  end
end
