class ApplicationService
  include ActiveModel::Model
  require "google/cloud/firestore"

  def firestore
    @firestore ||= Google::Cloud::Firestore.new(project_id: "battle-planner-development", credentials: 'config/firebase-authentication.json')
  end

end
