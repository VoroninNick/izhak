class UserCabinetController < ApplicationController
  #before_filter :ensure_signup_complete, only: [:index, :show, :edit, :update, :destroy]
  before_action :authenticate_user! #, only: [:index, :show, :edit, :update, :destroy]

  add_breadcrumb "<span>//</span> Особистий кабінет".html_safe, :my_index_path

  def index
    add_breadcrumb "Мій профайл", :user_cabinet_index_path
  end

  def history
    add_breadcrumb "Історія покупок", :user_cabinet_history_path
    @history = Order.where(user_id: current_user.id)
  end

  def subscribe
    add_breadcrumb "Підписка на розсилку", :user_cabinet_subscribe_path
  end

  def feedback
    add_breadcrumb "Залишити відгук", :user_cabinet_subscribe_path
  end

end
