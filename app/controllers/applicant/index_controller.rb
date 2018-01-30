class ApplicantController < ApplicationController
  let :APPLICANT, :all

  def index
    @applications = current_user.applicant.applications.all
    render html: "This id the index for applicants"
  end
  
end
