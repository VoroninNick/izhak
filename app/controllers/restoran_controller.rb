class RestoranController < ApplicationController
  before_action :get_admin
  before_action :authenticate_user!
  before_action :set_restoran, only: [:show, :edit, :update, :destroy]

  add_breadcrumb "<span>//</span> Особистий кабінет".html_safe, :my_index_path

  def index
    add_breadcrumb "Ресторани", :my_restoran_index_path
    @restorans = Restoran.all
  end

  def show
    add_breadcrumb "Ресторани", :my_restoran_index_path
  end

  def new
    add_breadcrumb "Ресторани", :my_restoran_index_path
    add_breadcrumb "Новий"
    @restoran = Restoran.new
  end

  def edit
    add_breadcrumb "Ресторани", :my_restoran_index_path
    add_breadcrumb "Редагуваня"
  end

  def create
    @restoran = Restoran.new(restoran_params)

    respond_to do |format|
      if @restoran.save
        format.html { redirect_to my_restoran_index_path, notice: 'Ресторан був успішно збережен.' }
        #format.json { render :show, status: :created, location: @restoran }
      else
        format.html { render :new }
        #format.json { render json: @restoran.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @restoran.update(restoran_params)
        format.html { redirect_to my_restoran_index_url, notice: 'Ресторан був успішно збережен.' }
        #format.json { render :show, status: :ok, location: @restoran }
      else
        format.html { render :edit }
        #format.json { render json: @restoran.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @restoran.destroy
    respond_to do |format|
      format.html { redirect_to my_restoran_index_url, notice: 'Restoran was successfully destroyed.' }
      #format.json { head :no_content }
    end
  end

  private

  def get_admin
    unless current_user.admin? || current_user.order_manager?
      redirect_to my_index_path, :notice => "Access denied."
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_restoran
    @restoran = Restoran.find_by_slug!(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def restoran_params
    params.require(:restoran).permit(:name, :slug, :content, :avatar)
  end
end
