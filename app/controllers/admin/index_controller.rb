class Admin::IndexController < ApplicationController

  let :admin, :all

  def index
    render html: "this is the admin index"
  end
  
end