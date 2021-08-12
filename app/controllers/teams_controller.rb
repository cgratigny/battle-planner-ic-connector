class TeamsController < ApplicationController
  before_action :find_team, only: [:show]
  before_action :build_collection, only: :index
  before_action :authenticate!

  require 'json'
  require 'net/http'
  require 'active_support/core_ext/hash'

  # GET /teams
  def index
    render json: @teams.map{ |team| team.to_h }
  end

  def show
    render json: @team
  end

  private

  def find_team
    @team = Team.find_by(team_id: params[:id])
  end

  def build_collection
    @teams = Team.member
  end

end
