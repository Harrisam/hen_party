class PartyInvitation < ActionMailer::Base

  default from: "chief-hen@chiefhen.com"

  def invitation_email(participant, subject, message)
    @message, @participant = message, participant
    mail(to: @participant.email, subject: subject)
  end

  def create_party_confirmation(user, party)
    @user, @party = user, party
    mail(to: @user.email, subject: 'Welcome to Hen Party')
  end

  def response_confirmation(participant, response)
    @participant, @response = participant, response 
    mail(to: @participant.email, subject: "You have joined #{@participant.party.name}")
  end

end
