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
require "test_helper"

class Podio::BattleTeamTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
