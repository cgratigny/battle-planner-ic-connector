# == Schema Information
#
# Table name: firestore_battle_plans
#
#  id                        :bigint           not null, primary key
#  calibration_data          :json
#  calibration_percentage    :integer
#  calibration_success_days  :integer
#  condition_data            :json
#  condition_percentage      :integer
#  condition_success_days    :integer
#  connection_data           :json
#  connection_percentage     :integer
#  connection_success_days   :integer
#  contribution_data         :json
#  contribution_percentage   :integer
#  contribution_success_days :integer
#  quarter                   :string
#  start_date                :date
#  total_days                :integer
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  firestore_user_id         :bigint
#
# Indexes
#
#  index_firestore_battle_plans_on_firestore_user_id  (firestore_user_id)
#
require "test_helper"

class Firestore::BattlePlanTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
