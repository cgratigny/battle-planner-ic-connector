class Team < MongoidRecord
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  field :team_id, type: Integer
  field :team_hash, type: String
  field :name, type: String
  field :members, type: Array
  field :updated_at, type: DateTime

  before_save :set_session_code

  has_many :users, foreign_key: :team_id, primary_key: :team_id

  def self.member
    where(team_type: :member)
  end

  def to_param
    team_hash
  end

  def to_h
    {
      id: self.team_id,
      team_hash: self.team_hash,
      name: self.name,
      members: self.members,
      updated_at: self.updated_at
    }
  end

  def set_session_code
    self.team_hash = SecureRandom.uuid unless self.team_hash.present?
  end


end
