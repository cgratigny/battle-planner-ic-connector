class TeamsController < ApplicationController
  before_action :find_team, only: [:show]
  before_action :build_collection, only: :index
  before_action :authenticate!

  require 'json'
  require 'net/http'
  require 'active_support/core_ext/hash'

  # GET /teams
  def index
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @teams.map{ |team| team.to_h } }
    end

  end

  def show
    render json: @team
  end

  private

  def authenticated?
    if action_name == "index"
      true
    else
      super
    end
  end

  def find_team
    @team = Podio::BattleTeam.find_by(team_id: params[:id])
  end

  def build_collection
    @teams = Podio::BattleTeam.member.alphabetical
  end

end
