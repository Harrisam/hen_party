require 'github/markdown'

class InvitationsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_party

  # GET /parties/1/invitation
  def new
  end

  # POST /parties/1/invitations
  def create
    subject = params[:party_invitations][:subject]
    message = GitHub::Markdown.render(params[:party_invitations][:message].html_safe)

    participants = @party.participants
    
    participants.each do |participant|
      begin
        PartyInvitation.invitation_email(participant, subject, message).deliver!
      rescue
      end
    end

    redirect_to @party, notice: 'Invitations successfully sent.'
  end

  private

    def set_party
      @party = Party.find(params[:party_id])
    end

    def invitation_params
      params.require(:invitation).permit(:subject, :message)
    end

end
