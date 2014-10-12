class OrderController < ApplicationController
  before_action :authenticate_user!
  before_action :get_admin
  before_action :set_order, only: [:edit, :update, :destroy]

  add_breadcrumb "<span>//</span> Особистий кабінет".html_safe, :my_index_path

  def index
    add_breadcrumb "Замовлення", :my_order_index_path
    @orders = Order.all
  end

  def edit
    add_breadcrumb "Замовлення", :my_order_index_path
    add_breadcrumb "Редагувати"
  end

  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to my_order_index_url, notice: 'Restoran was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to my_order_index_url, notice: 'Restoran was successfully destroyed.' }
    end
  end

  private

  def get_admin
    unless current_user.admin? || current_user.order_manager?
      redirect_to my_index_path, :notice => "Access denied."
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def order_params
    params.require(:order).permit(:is_approved, :user_id, :user, :total_price, :comment, :products)
  end
end
