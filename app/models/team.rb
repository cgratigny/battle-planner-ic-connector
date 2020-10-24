class Team
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  field :team_id, type: Integer
  field :name, type: String
  field :members, type: Array

  def self.member
    where(team_type: :member)
  end

end
