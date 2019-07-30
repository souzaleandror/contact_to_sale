class ReceiveEmailsController < ApplicationController
  before_action :set_receive_email, only: [:show, :edit, :update, :destroy]

  # GET /receive_emails
  # GET /receive_emails.json
  def index
    @receive_emails = ReceiveEmail.all
  end

  # GET /receive_emails/1
  # GET /receive_emails/1.json
  def show
  end

  # GET /receive_emails/new
  def new
    @receive_email = ReceiveEmail.new
  end

  # GET /receive_emails/1/edit
  def edit
  end

  # POST /receive_emails
  # POST /receive_emails.json
  def create
    @receive_email = ReceiveEmail.new(receive_email_params)

    respond_to do |format|
      if @receive_email.save
        format.html { redirect_to @receive_email, notice: 'Receive email was successfully created.' }
        format.json { render :show, status: :created, location: @receive_email }
      else
        format.html { render :new }
        format.json { render json: @receive_email.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /receive_emails/1
  # PATCH/PUT /receive_emails/1.json
  def update
    respond_to do |format|
      if @receive_email.update(receive_email_params)
        format.html { redirect_to @receive_email, notice: 'Receive email was successfully updated.' }
        format.json { render :show, status: :ok, location: @receive_email }
      else
        format.html { render :edit }
        format.json { render json: @receive_email.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /receive_emails/1
  # DELETE /receive_emails/1.json
  def destroy
    @receive_email.destroy
    respond_to do |format|
      format.html { redirect_to receive_emails_url, notice: 'Receive email was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_receive_email
      @receive_email = ReceiveEmail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def receive_email_params
      params.require(:receive_email).permit(:name, :phone, :message, :vehicle, :price, :year, :link_vehicle, :brand_behicle, :model_vehicle, :kilometer_vehicle, :accessories_vehicle)
    end
end
