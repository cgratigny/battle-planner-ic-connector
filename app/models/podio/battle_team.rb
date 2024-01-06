# == Schema Information
#
# Table name: podio_battle_teams
#
#  id                 :bigint           not null, primary key
#  members_array      :text             default([]), is an Array
#  name               :string
#  pending_processing :boolean
#  team_hash          :string
#  team_type          :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  team_id            :bigint
#
module Podio

  def self.table_name_prefix
    "podio_"
  end
  
  class BattleTeam < ApplicationRecord
    include Podio
    before_save :set_team_hash

    has_many :members, class_name: "Podio::Member", foreign_key: :podio_member_id

    scope :alphabetical, -> { order(name: :asc)}

    def users
      Firestore::User.where(team_id: self.team_id)
    end

    def self.member
      where(team_type: :member)
    end

    def self.set_all_to_be_processed!
      all.each do |team|
        team.update(pending_processing: true)
      end
    end

    def to_param
      team_id
    end

    def to_h
      {
        id: self.team_id,
        team_hash: self.team_hash,
        name: self.name,
        members_array: self.members,
        updated_at: self.updated_at
      }
    end

    def set_team_hash
      self.team_hash = SecureRandom.uuid unless self.team_hash.present?
    end

  end
end
