require 'invisiblehand'

class ProductsController < ApplicationController

  def index
    product_ids = { kit:          '02aecf7f1570ea714fdc00bf581ee66c',
                    shera:        'ff1cb21c78cfcaaddf58e445d2f24b56',
                    gay_bf:       '1f96b711b43040e94ebaa0ff42ac0195',
                    l_plates:     '18688049702bbfcc4f90602b57191970',
                    penis_straws: 'cd3c4f335954d2b5171ce0265871f96d' }
    products = product_ids.values.map { |id| product_details(id) }

    @best_price_pages = []
    products.each do |product|
      @best_price_pages << product.pages.min_by { |page| page.price + page.pnp  }
    end
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
