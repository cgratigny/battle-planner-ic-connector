class Member < MongoidRecord
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  field :member_id, type: Integer
  field :full_name, type: String
  field :first_name, type: String
  field :last_name, type: String
  field :status, type: String
  field :email, type: String
  field :team_id, type: Integer
  field :team_name, type: String
  field :updated_at, type: DateTime
  field :member_id, type: Integer

  after_save :update_user

  def self.active
    where(status: :active)
  end

  def self.deactivated
    where(status: :deactivated)
  end

  def member_item
    MemberItem.find(member_id)
  end

  def user
    User.where(email: self.email).first || Member.where(iron_council_email: self.email).first
  end

  def update_user
    return unless user.present?
    user.update(team_id: self.team_id, team_name: self.team_name)
  end

  def refresh(given_member_item = nil)
    given_member_item = member_item if given_member_item.nil?
    self.update(given_member_item.cache_attributes.merge({updated_at: Time.zone.now}))
  end

  def to_h
    {
      id: self.member_id,
      full_name: self.full_name,
      first_name: self.first_name,
      last_name: self.last_name,
      status: self.status,
      email: self.email,
      team_id: self.team_id,
      team_name: self.team_name,
      updated_at: self.updated_at
    }
  end

end
