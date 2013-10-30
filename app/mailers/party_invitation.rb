class PartyInvitation < ActionMailer::Base

  default from: "chief-hen@henparty.com"

  def invitation_email(participant, subject, message)
    @message, @participant = message, participant
    mail(to: participant.email, subject: subject)
  end

end
