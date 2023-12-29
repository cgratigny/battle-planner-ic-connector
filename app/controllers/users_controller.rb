class UsersController < ApplicationController
  before_action :find_user, only: [:show]
  before_action :build_collection, only: :index
  before_action :authenticate!

  require 'json'
  require "google/cloud/firestore"

  def show

  end

  # GET /users
  def index
    render json: Firestore::User.all.map{ |user| user.to_h(date: date) } if request.format.json?
    render xml: Firestore::User.all.map{ |user| user.to_h(date: date) } if request.format.xml?
  end

  def date
    params[:date].to_date || Date.today
  end

  private

  def find_user
    user = firestore.col("users").doc(params[:id]).get
    render json: Firestore::UserDecorator.new(user).to_h
  end

  def build_collection
    @users_collection = firestore.col("users").where(:teamId, :"=", 1281783109)
  end

  def firestore
    @firestore ||= Google::Cloud::Firestore.new(project_id: "battle-planner-development", credentials: 'config/firebase-authentication.json')
  end

end
