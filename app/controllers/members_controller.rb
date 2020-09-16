class MembersController < ApplicationController
  before_action :set_member, only: [:show, :update, :destroy]
  before_action :build_collection, only: :index
  before_action :authenticate!
  
  require 'json'
  require 'net/http'
  require 'active_support/core_ext/hash'

  # GET /members
  def index
    render json: @members
  end

  private

    def build_collection
      xml = Net::HTTP.get_response(URI.parse(podio_url)).body
      @members = Hash.from_xml(xml).to_json
    end

    def podio_url
      Rails.application.credentials.dig(:podio_url)
    end

end
