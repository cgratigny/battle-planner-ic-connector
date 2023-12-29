module Firestore
  class Firestore::User < ApplicationRecord
    include Firestore

    validates_uniqueness_of :firestore_id

    has_many :battle_plans, class_name: "Firestore::BattlePlan", foreign_key: "firestore_user_id"
    belongs_to :team, primary_key: :team_id, optional: true

    # This method syncs the user from the Firestore user.
    def self.sync_from_firestore_user(firestore_user)
      firestore_user_decorator = FirestoreUserDecorator.new(firestore_user)
      user = Firestore::User.find_or_create_by(firestore_id: firestore_user_decorator.id)
      user.update!(firestore_user_decorator.to_h)
    end

    # This method refreshes the user with the given member item.
    def refresh(given_member_item = nil)
      given_member_item = member_item if given_member_item.nil?
      self.update(given_member_item.cache_attributes.merge( { updated_at: Time.zone.now, pending_processing: false } ))
    end

    # This method returns the member.
    def member
      Member.where(email: self.email).first || Member.where(email: self.iron_council_email).first
    end

    # This method returns the user as a hash.
    def to_h(args = { date: Date.today })
      {
        id: firestore_id,
        podio_id: member.try(:podio_member_id),
        email: email,
        name: name,
        team_name: team_name,
        podio_team_id: team_id,
        zip_code: zip_code,
        age: age,
        created_at: created_at,
        gender: gender,
        image_url: image_url,
        iron_council_email: iron_council_email,
        phone: phone,
        start_date: start_date,
        plan_url: plan_url,
        current_plan: plans.current(args[:date]).try(:to_h, args),
        plans: plans.map{ |plan| plan.try(:to_h, args) }
      }
    end

  end
end