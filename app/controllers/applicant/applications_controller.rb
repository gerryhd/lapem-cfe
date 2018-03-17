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
    case application.application_type.id
      when ApplicationType::BRAND
        application.applicable = DistinctiveSign.new(distinctive_sign_params)
      when ApplicationType::PATENT
        application.applicable = IndustrialProperty.new(industrial_property_params)
      when ApplicationType::COPYRIGHT
        application.applicable = Copyright.new(copyright_params)
    end

    if application.save
      render json: {status: true}
    else
      render json: {status: false, errors: application.errors.full_messages}
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
        brand_types: BrandType.all,
        design_types: DesignType.all,
        type_requests: TypeRequest.all,
        copyright_branches: CopyrightBranch.all,
        derivation_types: DerivationType.all
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
    params.require(:application).permit(:application_type_id, data_general_attributes: [:phone, :fax, :name, :nationality, :state, address_data_attributes: [:zip_code, :street, :external_number, :internal_number, :colony, :municipality, :location, :federal_entity, :between_streets, :back_street, :country_id, :state], person_attributes: [:curp, :name, :first_last_name, :second_last_name, :nationality, :phone, :email, :social_reason, :rfc, :gender, :birth_date, :birth_location, :cell_phone, :participation_percent, :participation_type, :type_person_id]], address_notification_attributes: [address_data_attributes: [:zip_code, :street, :external_number, :internal_number, :colony, :municipality, :location, :federal_entity, :between_streets, :back_street, :country_id]])
  end

  def distinctive_sign_params
    params.require(:application).require(:distinctive_sign).permit(:file_sign, :sign_type_id, :brand_type_id, :distinctive_sign, :class_sign, :description, :tags, :first_date_use, :used_previous, establishment_location_attributes: [address_data_attributes: [:zip_code, :street, :external_number, :internal_number, :colony, :municipality, :location, :federal_entity, :between_streets, :back_street, :country_id]])
  end

  def industrial_property_params
    params.require(:application).require(:industrial_property).permit(:is_applicant_invention, :title, :previous_release_date, :divisional_number, :divisional_legal_concept, :divisional_date, :design_type_id, :type_request_id, data_inventor_attributes: [:nationality, :name, :phone, :fax, address_data_attributes: [:zip_code, :state, :street, :external_number, :internal_number, :colony, :municipality, :location, :federal_entity, :between_streets, :back_street, :country_id]], data_owner_attributes: [:nationality, :notification_people, :name, :phone, :fax, :rgp, address_data_attributes: [:zip_code, :street, :external_number, :internal_number, :colony, :municipality, :location, :federal_entity, :between_streets, :back_street, :country_id, :state]])
  end

  def copyright_params
    params.require(:application).require(:copyright).permit(:titular_is_author, :title, :copyright_branch_id, :derivation_type_id, :summary, :know_public, :publication_date, :is_derivated, general_data_author_attributes: [:nationality, :name, :first_last_name, :second_last_name, :email, :curp, :rfc, :gender, :birth_date, :birth_location, :cell_phone, :participation_percent, :participation_type, :phone, :fax, address_data_attributes: [:zip_code, :state, :street, :external_number, :internal_number, :colony, :municipality, :location, :federal_entity, :between_streets, :back_street, :country_id]], person_notification_attributes: [:curp, :rfc, :name, :first_last_name, :second_last_name], data_copyrights_attributes: [:title, :author], legal_representative_attributes: [:name, :first_last_name, :second_last_name, :phone, :email, :curp, :rfc, :cell_phone, :name_representative, address_data_attributes: [:zip_code, :street, :external_number, :internal_number, :colony, :municipality, :location, :federal_entity, :between_streets, :back_street, :country_id, :state]])
  end
end
