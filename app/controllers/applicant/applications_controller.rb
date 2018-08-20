class Applicant::ApplicationsController < ApplicationController
  let :applicant, :all
  before_action :set_application, only: [:show, :destroy, :update, :edit]

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
      NotificationMailer.new_application(current_user, application).deliver_now!
      render json: {status: true}
    else
      render json: {status: false, errors: application.errors.full_messages}
    end
  end

  def update
    result = false

    case @application.application_type.id
      when ApplicationType::BRAND
        result = @application.applicable.update(distinctive_sign_params)
      when ApplicationType::PATENT
        result = @application.applicable.update(industrial_property_params)
      when ApplicationType::COPYRIGHT
        result = @application.applicable.update(copyright_params)
    end
    if result && @application.update(application_params)
      #@application.status_application_id = StatusApplication::PENDING if @application.status_application_id == StatusApplication::OBSERVATIONS
      @application.save
      render json: {status: true}
    else
      render json: {status: false, errors: @application.errors.full_messages}
    end

  end

  def edit
    if @application.status_application.id != StatusApplication::OBSERVATIONS || current_user.id != @application.applicant.user_id
      redirect_to applicant_index_url
    end
    application = @application.as_json include: {
        applicant: {include: [:user]},
        data_general: {include: [:person, :address_data]},
        address_notification: {include: [:address_data]},
        observations: {include: [user: {include: [:type_user], only: [:username]}]},
    }

    case @application.application_type.id
      when ApplicationType::BRAND
        application[:distinctive_sign] = @application.applicable.as_json include: {
            establishment_location: { include: [ :address_data]}
        }
      when ApplicationType::PATENT
        application[:industrial_property] = @application.applicable.as_json include: {
            data_inventor: {include: [:address_data]},
            data_owner: {include: [:address_data]},
        }
      when ApplicationType::COPYRIGHT
        application[:copyright] = @application.applicable.as_json include: {
            general_data_author: {include: [:address_data]},
            person_notification: {},
            data_copyrights: {},
            legal_representative: { include: [:address_data]},
        }
    end

    @comments = application[:observations]
    @application = application
  end

  def show
    if current_user.id != @application.applicant.user_id
      redirect_to applicant_index_url
    end
    application = @application.as_json include: {
        applicant: {include: [:user]},
        data_general: {include: [:person, address_data: {include: [:country]}]},
        address_notification: {include: [address_data: {include: [:country]}]},
        observations: {include: [user: {include: [:type_user], only: [:username]}]},
    }

    case @application.application_type.id
      when ApplicationType::BRAND
        application[:distinctive_sign] = @application.applicable.as_json include: {
            establishment_location: { include: [address_data: {include: [:country]}]},
            brand_type: {},
            sign_type: {},
        }
      when ApplicationType::PATENT
        application[:industrial_property] = @application.applicable.as_json include: {
            data_inventor: {include: [address_data: {include: [:country]}]},
            data_owner: {include: [address_data: {include: [:country]}]},
            type_request: {},
            design_type: {},
        }
      when ApplicationType::COPYRIGHT
        application[:copyright] = @application.applicable.as_json include: {
            general_data_author: {include: [address_data: {include: [:country]}]},
            person_notification: {},
            data_copyrights: {},
            legal_representative: { include: [address_data: {include: [:country]}]},
            derivation_type: {},
            copyright_branch: {},
        }
    end

    @comments = application[:observations]
    @application = application
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
    params.require(:application).permit(:application_type_id, data_general_attributes: [:id, :phone, :fax, :name, :nationality, :state, address_data_attributes: [:id, :zip_code, :street, :external_number, :internal_number, :colony, :municipality, :location, :federal_entity, :between_streets, :back_street, :country_id, :state], person_attributes: [:id, :curp, :name, :first_last_name, :second_last_name, :nationality, :phone, :email, :social_reason, :rfc, :gender, :birth_date, :birth_location, :cell_phone, :participation_percent, :participation_type, :type_person_id]], address_notification_attributes: [:id, address_data_attributes: [:id, :zip_code, :street, :external_number, :internal_number, :colony, :municipality, :location, :federal_entity, :between_streets, :back_street, :country_id]], observations_attributes: [:id, :notes, :user_id])
  end

  def distinctive_sign_params
    params.require(:application).require(:distinctive_sign).permit(:file_sign, :sign_type_id, :brand_type_id, :distinctive_sign, :class_sign, :description, :tags, :first_date_use, :used_previous, establishment_location_attributes: [:id, address_data_attributes: [:id, :zip_code, :street, :external_number, :internal_number, :colony, :municipality, :location, :federal_entity, :between_streets, :back_street, :country_id]])
  end

  def industrial_property_params
    params.require(:application).require(:industrial_property).permit(:is_applicant_invention, :title, :previous_release_date, :divisional_number, :divisional_legal_concept, :divisional_date, :design_type_id, :type_request_id, data_inventor_attributes: [:id, :nationality, :name, :phone, :fax, address_data_attributes: [:id, :zip_code, :state, :street, :external_number, :internal_number, :colony, :municipality, :location, :federal_entity, :between_streets, :back_street, :country_id]], data_owner_attributes: [:id, :nationality, :notification_people, :name, :phone, :fax, :rgp, address_data_attributes: [:id, :zip_code, :street, :external_number, :internal_number, :colony, :municipality, :location, :federal_entity, :between_streets, :back_street, :country_id, :state]])
  end

  def copyright_params
    params.require(:application).require(:copyright).permit(:titular_is_author, :title, :copyright_branch_id, :derivation_type_id, :summary, :known_public, :publication_date, :is_derivated, general_data_author_attributes: [:id, :nationality, :name, :first_last_name, :second_last_name, :email, :curp, :rfc, :gender, :birth_date, :birth_location, :cell_phone, :participation_percent, :participation_type, :phone, :fax, address_data_attributes: [:id, :zip_code, :state, :street, :external_number, :internal_number, :colony, :municipality, :location, :federal_entity, :between_streets, :back_street, :country_id]], person_notification_attributes: [:id, :curp, :rfc, :name, :first_last_name, :second_last_name], data_copyrights_attributes: [:id, :title, :author], legal_representative_attributes: [:id, :name, :first_last_name, :second_last_name, :phone, :email, :curp, :rfc, :cell_phone, :name_representative, address_data_attributes: [:id, :zip_code, :street, :external_number, :internal_number, :colony, :municipality, :location, :federal_entity, :between_streets, :back_street, :country_id, :state]])
  end
end
