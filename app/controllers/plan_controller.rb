class PlanController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_party
  before_action :get_best_price_pages

  def index
    @participants = @party.participants
    @budget_responses = budget_responses
    @budget_options = @party.budgets
    @date_responses = date_responses
    @date_options = @party.date_options
  end

  def product_search
    # search_terms = params[:product][:search]
    # @product_search_results = get_product_search_results(search_terms)
    # render 'plan'
    redirect_to plan_party_path(@party)
  end

  def accommodation_search
    search_terms = params[:accommodation]
    @check_in = l(search_terms[:arrival_date].to_date, format: :uk)
    @check_out = l(search_terms[:departure_date].to_date, format: :uk)
    @accommodation_results = get_accommodation_list(search_terms)
    render 'index'
  end

  def itinerary
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_party
      @party = Party.find(params[:party_id])
    end

    def budget_responses
      # @budget_responses = @party.budgets.inject() { |totals, budget| totals[budget.amount] = budget.participants.size }
      @party.participants.each do |party_participant|
        unless party_participant.response.nil? || party_participant.response.budgets.nil? 
          party_participant.response.budgets.each do |budget_response|
            @budget_responses.nil? ? @budget_responses = [budget_response.amount] : @budget_responses << budget_response.amount
          end
        end
      end
      @budget_responses
    end 

    def date_responses
      # @budget_responses = @party.budgets.inject() { |totals, budget| totals[budget.amount] = budget.participants.size }
      @party.participants.each do |party_participant|
        unless party_participant.response.nil? || party_participant.response.date_options.nil? 
          party_participant.response.date_options.each do |date_response|
            @date_responses.nil? ? @date_responses = [date_response.id] : @date_responses << date_response.id
          end
        end
      end
      @date_responses
    end

    def get_best_price_pages
      products = { kit:          '02aecf7f1570ea714fdc00bf581ee66c',
                   shera:        'ff1cb21c78cfcaaddf58e445d2f24b56',
                   gay_bf:       '1f96b711b43040e94ebaa0ff42ac0195',
                   l_plates:     '18688049702bbfcc4f90602b57191970',
                   penis_straws: 'cd3c4f335954d2b5171ce0265871f96d' }
      begin
        @best_price_pages = best_pages(products.values)
      rescue
        @best_price_pages = false
      end
    end

    def best_pages(product_ids)
      products = product_ids.map { |id| product_details(id) }
      products.inject([]) do |best_pages, product|
        best_pages << product.pages.min_by { |page| page.price + page.pnp  }
      end
    end

    def get_product_search_results(search_term)
      search_results = invisible_hand_api.products(
                                     :query => search_term,
                                     :sort => "popularity",
                                     :order => "desc",
                                     :size => "3")
      best_pages(search_results.map { |product| product.id })
    end

    def invisible_hand_api
      @invisible_hand_api ||= InvisibleHand::API.new(
                                :app_id => ENV['INVISIBLE_HAND_APP_ID'],
                                :app_key => ENV['INVISIBLE_HAND_APP_KEY'],
                                :region => 'uk')
    end

    def product_details(product_id)
      invisible_hand_api.product(product_id)
    end

    def expedia_api
      @expedia_api ||= Expedia::Api.new
    end

    def get_accommodation_list(search_terms)
      api_request = {
        numberOfResults:  20,
        countryCode:      'GB',
        city:             search_terms[:city],
        propertyCategory: search_terms[:property_category],
        arrivalDate:      l(search_terms[:arrival_date].to_date, format: :us),
        departureDate:    l(search_terms[:departure_date].to_date, format: :us),
        maxRate:          search_terms[:max_rate] * 2
      }
      api_response = expedia_api.get_list(api_request)
      accommodation_list = api_response.body["HotelListResponse"]["HotelList"]["HotelSummary"]

      accommodation_list.reject! do |accommodation|
        rooms_available = accommodation['RoomRateDetailsList']['RoomRateDetails']['currentAllotment']
        room_occupancy = accommodation['RoomRateDetailsList']['RoomRateDetails']['quotedRoomOccupancy']
        rooms_available == 0 || room_occupancy * rooms_available < search_terms[:guests].to_i 
      end
      accommodation_list.take(5)
    end

end
