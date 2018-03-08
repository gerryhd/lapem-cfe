class Applicant::ApplicationsController < ApplicationController
  let :applicant, :all
  before_action :set_application, only: [:show, :destroy, :update]

  def new

  end

  def index
  end

  def create
    application = Application.new(application_params)
    application.applicant = current_user.applicant
    application.applicable = DistinctiveSign.new(distinctive_sign_params)
    if application.save
      render json: {status: true}
    else
      render json: {status: true, errors: application.errors.full_messages}
    end
  end

  def update
  end

  def show
  end

  def general_information
    render json: {
        application_types: ApplicationType.all,
        type_persons: TypePerson.all,
        countries: Country.all,
        sign_types: SignType.all,
        brand_types: BrandType.all
    }
  end

  def destroy
    if @application.destroy
      render json: {status: true}
    else
      render json: {status: false, errors: @application.errors.full_messages}
    end
  end

  private
  def set_application
    @application = Application.find(params[:id])
  end

  def application_params
    params.require(:application).permit(:application_type_id, data_general_attributes: [:name, :nationality, :state, person_attributes: [:curp, :name, :first_last_name, :second_last_name, :nationality, :phone, :email, :social_reason, :rfc, :gender, :birth_date, :birth_location, :cell_phone, :participation_percent, :participation_type, :type_person_id]], address_notification_attributes: [address_data_attributes: [:zip_code, :street, :external_number, :internal_number, :colony, :municipality, :location, :federal_entity, :between_street, :back_street, :country_id]])
  end

  def distinctive_sign_params
    params.require(:application).require(:distinctive_sign).permit(:file_sign, :sign_type_id, :brand_type_id, :distinctive_sign, :class_sign, :description, :tags)
  end
end
