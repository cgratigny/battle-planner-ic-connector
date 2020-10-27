class TeamsController < ApplicationController
  before_action :set_member, only: [:show, :update, :destroy]
  before_action :build_collection, only: :index
  before_action :authenticate!

  require 'json'
  require 'net/http'
  require 'active_support/core_ext/hash'

  # GET /teams
  def index
    render json: @teams.map{ |team| team.to_h }
  end

  private

  def build_collection
    @teams = Team.member
  end

end
