class PartiesController < ApplicationController
  before_filter :authenticate_user!, except: [:new, :create, :join]
  before_action :set_party, only: [:show,
                                   :edit,
                                   :update,
                                   :destroy,
                                   :invitation,
                                   :send_invitations]
  helper_method :party_and_user_errors
  helper_method :send_email

  # GET /parties
  # GET /parties.json
  def index
    @parties = current_user.parties.all
  end

  # GET /parties/1
  # GET /parties/1.json
  def show
    @party = Party.find params[:id]
    if !current_user.parties.include?(@party)
      render :text => "<h1>Sorry, you don't have access to this party.</h1>", :status => '404', :layout => true
    end
  end

  # GET /parties/1/invitation
  def invitation
  end

  # POST /parties/1/send_invitations
  def send_invitations
    subject = params[:invitation][:subject]
    message = params[:invitation][:message]

    participants = @party.participants
    
    participants.each do |participant|
      PartyInvitation.invitation_email(participant, subject, message).deliver!
    end

    redirect_to @party, notice: 'Invitations successfully sent.'
  end

  def join
    @participant = Participant.find_by_token(params[:token])
    
    if @participant
      @party = @participant.party
    else
      render :text => "<h1>Sorry, we can't find your party.</h1>", :status => '404', :layout => true
    end
  end

  # GET /parties/new
  def new
    @party = Party.new
    @user = User.new
    1.times do
    question = @party.budgets.build
    end
    1.times do
    date_option = @party.date_options.build
    end
    1.times do
    participant = @party.participants.build
    end
  end

  # GET /parties/1/edit
  def edit
    @party = Party.find params[:id]
  end

  # POST /parties
  # POST /parties.json
  def create
    @party = Party.new(party_params)
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save && @party.save
        @party.assign_chief_hen(@user)
        sign_in(@user)
        PartyInvitation.create_party_confirmation(@user, @party).deliver!
        format.html { redirect_to @party, notice: 'Party was successfully created.' }
        format.json { render action: 'show', status: :created, location: @party }
      else
        format.html { render action: 'new' }
        format.json { render json: @party.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parties/1
  # PATCH/PUT /parties/1.json
  def update
    respond_to do |format|
      if @party.update(party_params)
        format.html { redirect_to @party, notice: 'Party was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @party.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parties/1
  # DELETE /parties/1.json
  def destroy
    @party.destroy
    respond_to do |format|
      format.html { redirect_to parties_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_party
      @party = Party.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def party_params
      params.require(:party).permit(:name, budgets_attributes: [:id, :_destroy, :amount], participants_attributes: [:id, :_destroy, :email, :first_name, :last_name], date_options_attributes: [:id, :_destroy, :start_date, :end_date])
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end

    def invitation_params
      params.require(:invitation).permit(:subject, :message)
    end

    def party_and_user_errors
      @party.errors.full_messages + @user.errors.full_messages
    end

end
