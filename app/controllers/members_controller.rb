class MembersController < ApplicationController
  before_action :set_member, only: [:show, :update, :destroy]
  before_action :build_collection, only: :index
  before_action :authenticate!

  require 'json'
  require 'net/http'
  require 'active_support/core_ext/hash'

  # GET /members
  def index
    render json: @members.map{ |member| member.to_h }
  end

  private

  def build_collection
    if params[:status] == :active.to_s
      @members = Podio::Member.active
    elsif params[:status] == :deactivated.to_s
      @members = Podio::Member.deactivated
    else
      @members = Podio::Member.all
    end
  end

end
