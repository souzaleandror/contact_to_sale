class ReceiveEmailsController < ApplicationController
  before_action :set_receive_email, only: [:show, :edit, :update, :destroy]

  def read_email

    msg_error = ""

    if ((params[:receive_email]) && (params[:receive_email][:file].present?))

      file_data = params[:receive_email][:file].read
      
      html_doc = Nokogiri::HTML.parse(file_data)

      if ((file_data.nil?) || (html_doc.nil?))
        flash[:error] = 'Error read emails file. try again.2'  
        redirect_to root_path
      end

      @name = (!html_doc.css('b')[1].nil? ? html_doc.css('b')[1].next.text.strip : "N/A")
      @email = (!html_doc.css('b')[2].nil? ? html_doc.css('b')[2].next.text.strip : "N/A")
      @phone = (!html_doc.css('b')[3].nil? ? html_doc.css('b')[3].next.text.strip : "N/A")
      @message = (!html_doc.css('b')[4].nil? ? html_doc.css('b')[4].next.next.text.strip : "N/A")

      @vehicle = (!html_doc.css('b')[5].nil? ? html_doc.css('b')[5].next.text.strip : "N/A")
      @price = (!html_doc.css('b')[6].nil? ? html_doc.css('b')[6].next.text.strip : "N/A")
      @year = (!html_doc.css('b')[7].nil? ? html_doc.css('b')[7].next.text.strip : "N/A")
      @link_vehicle = (!html_doc.css('b')[8].nil? ? html_doc.css('b')[8].next.next.next.text.strip : "N/A")

      @receive_email = ReceiveEmail.new
      @receive_email.name = @name
      @receive_email.email = @email
      @receive_email.phone = @phone
      @receive_email.message = @message
      @receive_email.vehicle = @vehicle
      @receive_email.price = @price
      @receive_email.year = @year
      @receive_email.link_vehicle = (@link_vehicle != 'N/A' ? @link_vehicle.last(-1).gsub("\n","").gsub("\r","") : @link_vehicle)

      if ((@receive_email.link_vehicle.present?) && (valid_url?(@receive_email.link_vehicle))) then

        doc = HTTParty.get(@receive_email.link_vehicle)
        link_html_doc = Nokogiri::HTML(doc)

        @brand_vehicle = (!link_html_doc.css('.vehicle-info').css('.row').css('.col-3')[5].nil? ? link_html_doc.css('.vehicle-info').css('.row').css('.col-3')[5].css('p').inner_text.strip : "N/A")
        @model_vehicle = (!link_html_doc.css('.vehicle-info').css('.row').css('.col-3')[1].nil? ? link_html_doc.css('.vehicle-info').css('.row').css('.col-3')[1].css('p').inner_text.strip : "N/A")
        @kilometer_vehicle = (!link_html_doc.css('.vehicle-info').css('.row').css('.col-3')[3].nil? ? link_html_doc.css('.vehicle-info').css('.row').css('.col-3')[3].css('p').inner_text.strip : "N/A")
        @accessories_vehicle = ""

        if !link_html_doc.css('.vehicle-accessories').css('.row').css('.col-4').nil? then 
          link_html_doc.css('.vehicle-accessories').css('.row').css('.col-4').css('p').each do |row|
            @accessories_vehicle += row.inner_text.to_s.titleize + ' / '
          end
        else 
          @accessories_vehicle = "N/A"
        end
        @receive_email.brand_vehicle = @brand_vehicle
        @receive_email.model_vehicle = @model_vehicle
        @receive_email.kilometer_vehicle = @kilometer_vehicle
        @receive_email.accessories_vehicle = @accessories_vehicle
      else 
        @receive_email.brand_vehicle = @receive_email.model_vehicle = @receive_email.kilometer_vehicle = @receive_email.accessories_vehicle = "N/A"
        msg_error = 'Error read link vehicle.'
      end

      if msg_error.empty?
        flash[:notice] = 'Read email was successfully.'
      else
        flash[:error] = msg_error
      end

      respond_to do |format|
        format.html { render :after_read_email }
      end

    else
      flash[:error] = 'Error read emails file. try again.'  
      redirect_to root_path
    end
  end

  def after_read_email
    #puts @receive_email
  end

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
      params.require(:receive_email).permit(:name, :email, :phone, :message, :vehicle, :price, :year, :link_vehicle, :brand_vehicle, :model_vehicle, :kilometer_vehicle, :accessories_vehicle)
    end

    def valid_url?(url)
      uri = URI.parse(url)
      uri.is_a?(URI::HTTP) && !uri.host.nil?
    rescue URI::InvalidURIError
      false
    end

end
