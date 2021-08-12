class FirestoreService < ApplicationService
  attr_accessor :date, :team

  def initialize(args = {})
    super
    self.date = Date.today if self.date.nil?
  end

  def sync_users
    users_collection.get.each do |firestore_user|
      User.sync_from_firestore_user(firestore_user)
    end
  end

  def sync_plans
    users_collection.get.each do |firestore_user|
      Plan.sync_from_firestore_user(firestore_user, date)
    end
  end

  def sync_progress
    users_collection.get.each do |firestore_user|
      begin
        plan = Plan.by_firestore_user(firestore_user).by_date(date).first
        plan.sync_for_date(date) if plan.present?
      rescue
      end
    end
  end

  def sync_progress_for_week
    (self.date.beginning_of_week..self.date.end_of_week).each do |date|
      FirestoreService.new(date: date).sync_progress
    end
  end

  def users_collection
    collection = firestore.col("users").where(:status, :"=", :active)
    collection.where(:team_id, :"=", team.team_id) if team.present?
    collection
  end

end
