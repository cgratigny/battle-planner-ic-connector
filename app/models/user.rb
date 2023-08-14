# This class represents a user in the application. It includes Mongoid::Document and Mongoid::Attributes::Dynamic modules.
# It has several fields such as firestore_id, name, email, team_name, team_id, age, created_at, image_url, iron_council_email, phone, zip_code, gender, start_date, and plan_url.
# It validates the uniqueness of firestore_id and has a has_many association with plans and a belongs_to association with team.
# It has several methods such as sync_from_firestore_user, refresh, member, and to_h.
class User < MongoidRecord
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  field :firestore_id, type: String
  field :name, type: String
  field :email, type: String
  field :team_name, type: String
  field :team_id, type: Integer
  field :age, type: Integer
  field :created_at, type: DateTime
  field :image_url, type: String
  field :iron_council_email, type: String
  field :phone, type: String
  field :zip_code, type: String
  field :gender, type: String
  field :start_date, type: DateTime
  field :plan_url, type: String
  field :status, type: String

  validates_uniqueness_of :firestore_id

  has_many :plans
  belongs_to :team, primary_key: :team_id, optional: true

  # This method syncs the user from the Firestore user.
  def self.sync_from_firestore_user(firestore_user)
    firestore_user_decorator = FirestoreUserDecorator.new(firestore_user)
    user = User.find_or_create_by(firestore_id: firestore_user_decorator.id)
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
      podio_id: member.try(:member_id),
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
