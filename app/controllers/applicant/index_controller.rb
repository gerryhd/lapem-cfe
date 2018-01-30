class Applicant::IndexController < ApplicationController

  let :applicant, :all

  def index
    # @applications = current_user.applicant.applications.all
    render html: "This is the index for applicants"
  end
  
end
