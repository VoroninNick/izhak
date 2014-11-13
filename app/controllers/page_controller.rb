class PageController < ApplicationController

  def index
    @recommended ||= Product.last(4)
    @current_day = DateTime.now.wday
  end

  def restorans

  end

  def restorans_item
    @restoran = Restoran.find_by_slug!(params[:id]) #.paginate(page: params[:page], per_page: 16)
    #@menus = @restoran.categories
    category_ids = @restoran.categories.each { |category| category.id }
    @products ||= Product.unscoped.where(category_id: category_ids.to_a)
    #@products = @menus.products.paginate(page: params[:page], per_page: 16)
    logger.info "------------------------ START DEBUG RESTORAN ------------------------"
    #logger.info @restoran.inspect
    #logger.info @products.inspect
    logger.info "------------------------ END   DEBUG RESTORAN ------------------------"
    @total = Product.where(category_id: @restoran.categories).count
    add_breadcrumb "<span>//</span> #{@restoran.name}".html_safe
    add_breadcrumb "Все меню"
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
