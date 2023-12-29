class FirestoreUserDecorator < ApplicationDecorator

  def to_h
    {
      firestore_id: id,
      email: @model[:email],
      name: @model[:name],
      team_name: @model[:teamName],
      team_id: @model[:teamId],
      zip_code: @model[:zipCode],
      age: @model[:age],
      account_created_at: @model[:createdAt],
      gender: @model[:gender],
      image_url: @model[:imageUrl],
      iron_council_email: @model[:ironCouncilEmail],
      phone: @model[:phone],
      start_date: @model[:startdate],
      plan_url: plan_url,
      status: @model[:status]
    }
  end

  def plan_to_h
    {
      calibration_success_days: success_days(:calibration),
      connection_success_days: success_days(:connection),
      condition_success_days: success_days(:condition),
      contribution_success_days: success_days(:contribution),
      calibration_percentage: percentage(:calibration),
      connection_percentage: percentage(:connection),
      condition_percentage: percentage(:condition),
      contribution_percentage: percentage(:contribution),
      total_days: total_days
    }
  end

  def id
    @model.path.split('/')[-1]
  end

  def plan_url
    "https://app.12weekbattleplanner.com/plan/#{id}"
  end

  def quarter_string
    QuarterService.new(date: Date.today).quarter_string
  end

  def quarter
    (Date.today.beginning_of_quarter.month - 1 )/ 3 + 1
  end

  def days_since_quarter_start
    QuarterService.new(date: Date.today).days_since_quarter_start
  end

  def success_days(quadrant)
    begin
      quarter_data["#{quadrant.upcase}count"]
    rescue
      0
    end
  end

  def percentage(quadrant)
    (success_days(quadrant).to_f / total_days.to_f * 100).round
  end

  def total_days
    days_since_quarter_start
  end

  def quarter_data
    @quarter_data ||= firestore.col("users").doc(id).col("STARTDATES").doc(quarter_string).get
  end

  def firestore
    @firestore ||= Google::Cloud::Firestore.new(project_id: "battle-planner-development", credentials: 'config/firebase-authentication.json')
  end

end
