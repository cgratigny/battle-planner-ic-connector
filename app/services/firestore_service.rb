class FirestoreService < ApplicationService
  attr_accessor :date, :team

  def initialize(args = {})
    super
    self.date = Date.today if self.date.nil?
  end

  def sync_users
    puts " = Sync Users".black.bold
    users_collection.get.each do |firestore_user|
      puts " - Process #{firestore_user.get(:email)}".gray
      begin
        Firestore::User.sync_from_firestore_user(firestore_user)
      rescue => e
        Honeybadger.notify(e)
      end
    end
  end

  def sync_plans
    puts " = Sync Plans".black.bold
    users_collection.get.each do |firestore_user|
      puts " - Process #{firestore_user.get(:email)}".gray
      begin
        Firestore::BattlePlan.sync_from_firestore_user(firestore_user, date)
      rescue => e
        Honeybadger.notify(e)
      end
    end
  end

  def sync_progress
    puts " = Sync Progress".black.bold
    battle_plans = Firestore::BattlePlan.by_date(date).joins(:firestore_user).includes(:firestore_user)
    battle_plans = battle_plans.where(firestore_user: { team_id: team.team_id }) if team.present?

    battle_plans.each do |plan|
      puts " - Process #{plan.firestore_user.email}".gray
      begin
        plan.sync_for_date(date)
      rescue => e
        Honeybadger.notify(e)
      end
    end
  end

  def sync_progress_for_week
    (self.date.beginning_of_week..self.date.end_of_week).each do |date|
      FirestoreService.new(date: date, team: team).sync_progress
    end
  end

  def users_collection
    collection = firestore.col("users").where(:status, :"!=", nil) # .where(:status, :"=", :active)
    collection.where(:team_id, :"=", team.team_id) if team.present?
    collection
  end


end
