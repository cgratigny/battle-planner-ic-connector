class Member
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

  def self.active
    where(status: :active)
  end

  def self.deactivated
    where(status: :deactivated)
  end

  def member_item
    MemberItem.find(member_id)
  end

  def refresh(given_member_item = nil)
    given_member_item = member_item if given_member_item.nil?
    self.update(given_member_item.cache_attributes.merge({updated_at: Time.zone.now}))
  end

end
