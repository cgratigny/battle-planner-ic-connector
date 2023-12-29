# module Firestore
  class Firestore::BattlePlan < ApplicationRecord
    # include Firestore
    belongs_to :firestore_user, class_name: 'Firestore::User'

    def self.by_firestore_user(given_firestore_user)
      firestore_user_decorator = FirestoreUserDecorator.new(given_firestore_user)
      where(firestore_user: Firestore::User.find_by(firestore_id: firestore_user_decorator.id))
    end

    def self.by_date(given_date)
      where(quarter: QuarterService.new(date: given_date).quarter_string)
    end

    def self.current(given_date)
      by_date(given_date).first
    end


    def self.sync_from_firestore_user(firestore_user, date)
      firestore_user_decorator = FirestoreUserDecorator.new(firestore_user)
      plan = Firestore::BattlePlan.find_or_create_by(quarter: firestore_user_decorator.quarter_string, firestore_user: Firestore::User.find_by(firestore_id: firestore_user_decorator.id))
      plan.update(firestore_user_decorator.plan_to_h)
      plan.save!
    end

    def sync_for_date(date)
      ["CALIBRATION", "CONNECTION", "CONDITION", "CONTRIBUTION"].each do |quadrant|
        attribute = "#{quadrant.downcase}_data"
        new_data = (self.send(attribute) || {}).merge("#{date.to_fs(:simple)}": firestore_success_for_date?(quadrant: quadrant, date: date))
        self.assign_attributes(attribute => new_data)
      end
      self.save
    end

    def firestore_success_for_date?(args)      
      begin
        remote_firestore_user.col(args[:quadrant].upcase).doc(args[:date].to_fs(:firestore_date)).get[args[:date].to_fs(:firestore_date).to_sym]
      rescue
        false
      end
    end

    def remote_firestore_user
      @remote_firestore_user ||= firestore.col("users").doc(self.firestore_user.firestore_id)
    end

    def success?(args)
      begin
        self.send("#{args[:quadrant].downcase}_data")[args[:date].to_fs(:simple)]
      rescue
        nil
      end
    end

    def percentage_for_week(args)
      start_date = args[:date].beginning_of_week.to_date
      end_date = args[:date].end_of_week.to_date
      successes = []
      quadrants = args[:quadrant].present? ? [args[:quadrant]] : ["CALIBRATION", "CONNECTION", "CONDITION", "CONTRIBUTION"]
      quadrants.each do |quadrant|
        (start_date..end_date).each do |date|
          successes << success?(quadrant: quadrant.downcase, date: date)
        end
      end
      [((successes.count(true).to_f / (week_days(args).to_f * quadrants.count.to_f).to_f) * 100).round, 100].min
    rescue
      0
    end

    def week_days(args)
      if args[:date].end_of_week.to_date.future?
        (Date.today - args[:date].beginning_of_week.to_date) + 1
      else
        7
      end
    end

    def to_h(args = { date: Date.today })
      {
        quarter: self.quarter,
        date: args[:date],
        week_start: args[:date].beginning_of_week,
        week_end: args[:date].end_of_week,
        calibration_success_days: self.calibration_success_days,
        connection_success_days: self.connection_success_days,
        condition_success_days: self.condition_success_days,
        contribution_success_days: self.contribution_success_days,
        calibration_percentage: self.calibration_percentage,
        connection_percentage: self.connection_percentage,
        condition_percentage: self.condition_percentage,
        contribution_percentage: self.contribution_percentage,
        calibration_week_percentage: self.percentage_for_week(quadrant: :calibration, date: args[:date]),
        connection_week_percentage: self.percentage_for_week(quadrant: :connection, date: args[:date]),
        condition_week_percentage: self.percentage_for_week(quadrant: :condition, date: args[:date]),
        contribution_week_percentage: self.percentage_for_week(quadrant: :contribution, date: args[:date])
      }
    end

    def plan_url
      "https://app.12weekbattleplanner.com/plan/#{self.firestore_user.firestore_id}/#{self.quarter}"
    end

  end
# end