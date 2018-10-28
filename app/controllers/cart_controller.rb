class CartController < ApplicationController

  def index
    @items = @cart.cart_items
  end

  def destroy
    # binding.pry
    session[:cart].delete(params[:item_id].to_s)
    redirect_back(fallback_location: root_path)
  end

  def update
    session[:cart][params[:item_id]] = params[:number].to_i
    redirect_back(fallback_location: root_path)
  end

  def create
    session[:cart] ||= Hash.new(0)
    item = Item.find(params[:item_id])
    session[:cart][item.id.to_s] ||= 0
    session[:cart][item.id.to_s] += 1
    flash[:success] = "#{item.name.capitalize} added to cart"
    redirect_back(fallback_location: root_path)
  end

end