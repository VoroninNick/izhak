class PageController < ApplicationController
  def index
  end

  def restorans

  end

  def restorans_item

  end

  def catalogs

  end

  def catalogs_item

  end

  def products

  end

  def products_item

  end



  # Order system
  def order

  end

  def new_order
    @order = Order.new
  end

  def submit_order
    @order = Order.new(order_params)

    if @order.save

    else

    end

  end


  private

  def order_params
    params.require(:order).permit(:comment, :products)
  end

end
