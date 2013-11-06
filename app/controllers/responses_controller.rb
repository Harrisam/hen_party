class ResponsesController < ApplicationController
  
  def new
    @participant = Participant.find_by_token(params[:token])
    
    if @participant
      @party = @participant.party
      @response = Response.new
    else
      render :text => "<h1>Sorry, we can't find your party.</h1>", :status => '404', :layout => true
    end
  end

  def create
    @participant = Participant.find_by_token(params[:token])
    @participant.response = Response.create!(params[:response].permit!)
    begin
      PartyInvitation.response_confirmation(@participant, @participant.response).deliver!
    rescue
    end
    render :text => "<h1>Your response has been well received, it is party time!</h1>", :layout => true
  end

end
