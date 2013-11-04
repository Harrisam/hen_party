require 'invisiblehand'

class ProductsController < ApplicationController

  def index
    product_ids = { shera:    'ff1cb21c78cfcaaddf58e445d2f24b56',
                    gay_bf:   '1f96b711b43040e94ebaa0ff42ac0195',
                    l_plates: '18688049702bbfcc4f90602b57191970' }
    @products = product_ids.values.map { |id| product_details(id) }
  end

  def invisible_hand_api
    InvisibleHand::API.new :app_id => ENV['INVISIBLE_HAND_APP_ID'],
                           :app_key => ENV['INVISIBLE_HAND_APP_KEY'],
                           :region => 'uk'
  end

  def product_details(product_id)
    @api ||= invisible_hand_api
    @api.product(product_id)
  end

end
