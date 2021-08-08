class Team < MongoidRecord
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  field :team_id, type: Integer
  field :name, type: String
  field :members, type: Array
  field :updated_at, type: DateTime

  def self.member
    where(team_type: :member)
  end

  def to_h
    {
      id: self.team_id,
      name: self.name,
      members: self.members,
      updated_at: self.updated_at
    }
  end

end
