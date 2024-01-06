# == Schema Information
#
# Table name: firestore_users
#
#  id                 :bigint           not null, primary key
#  account_created_at :datetime
#  age                :integer
#  email              :string
#  gender             :string
#  image_url          :string
#  iron_council_email :string
#  name               :string
#  phone              :string
#  plan_url           :string
#  start_date         :datetime
#  status             :string
#  team_name          :string
#  zip_code           :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  firestore_id       :string
#  podio_team_id      :bigint
#  team_id            :string
#
# Indexes
#
#  index_firestore_users_on_podio_team_id  (podio_team_id)
#
require "test_helper"

class Firestore::UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
