class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  let :all, [:index]

  def index
    render html: 'this is the index for everyone'
  end
end
