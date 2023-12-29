module Podio
  def self.table_name_prefix
    "podio_"
  end

  class Member < ApplicationRecord

    after_save :update_user

    scope :active, -> { where(status: :active) }
    scope :deactivated, -> { where(status: :deactivated) }

    def self.set_all_to_be_processed!
      all.each do |member|
        member.update(pending_processing: true)
      end
    end

    def self.delete_unprocessed!
      where(pending_processing: true).each do |member|
        member.destroy
      end
    end

    def active?
      self.status.to_sym == :active
    end

    def member_item
      MemberItem.find(podio_member_id)
    end

    def user
      Firestore::User.where(email: self.email).first || Member.where(iron_council_email: self.email).first
    end

    def update_user
      return unless user.present? && user.is_a?(User)
      user.update(team_id: self.team_id, team_name: self.team_name)
    end

    def refresh(given_member_item = nil)
      given_member_item = member_item if given_member_item.nil?
      self.update(given_member_item.cache_attributes.merge( { updated_at: Time.zone.now, pending_processing: false } ))
    end

    def to_h
      {
        id: self.podio_member_id,
        full_name: self.full_name,
        first_name: self.first_name,
        last_name: self.last_name,
        status: self.status,
        email: self.email,
        team_id: self.api_team_id,
        team_name: self.api_team_name,
        updated_at: self.updated_at
      }
    end

    def api_team_id
      return nil unless self.active?
      self.team_id
    end

    def api_team_name
      return nil unless self.active?
      self.team_name
    end
  end
end