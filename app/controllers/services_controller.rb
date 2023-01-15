class ServicesController < ApplicationController
  require "rqrcode"
  def index

  end

  def shop
    @services = Service.all

  end

  def show
    @service = Service.find(params[:id])
  end

  def facilities
    @services = Service.all
  end

  def individual
    @services = Service.all
  end

  def appartments
    @services = Service.all
  end

  def get_time_slots
    day = params[:day]
    service = Service.find(params[:id])
    data =  render_to_string partial: "time_slot_json", locals: {day: day, service: service}
    render json: {
      data: data
    }
  end

  def book_appointment
    require "rqrcode"

    qrcode = RQRCode::QRCode.new("http://65.108.74.195:3001/")

    # NOTE: showing with default options specified explicitly
    @qr_code = qrcode.as_svg(
      color: "000",
      shape_rendering: "crispEdges",
      module_size: 11,
      standalone: true,
      use_path: true
    )

    @service = Service.find(params[:service_id])
    if params[:day_slot].present? && params[:time_slot].present?
       @appointment = Appointment.new
       @appointment.client_id = @service.service_provider_id
       @appointment.service_provider_id = @service.service_provider_id
       @appointment.day_slot = params[:day_slot]
       @appointment.time_slot = params[:time_slot]
       @appointment.service_id = @service.id
       if @appointment.save

       else
         redirect_to '/'
       end
    else

    end
    end

end
