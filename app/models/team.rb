class Team < MongoidRecord
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  field :team_id, type: Integer
  field :team_hash, type: String
  field :name, type: String
  field :members, type: Array
  field :updated_at, type: DateTime
  field :pending_processing, type: Boolean

  before_save :set_team_hash

  has_many :users, foreign_key: :team_id, primary_key: :team_id
  scope :alphabetical, -> { order(name: :asc)}

  def self.member
    where(team_type: :member)
  end

  def self.set_all_to_be_processed!
    all.each do |team|
      team.update(pending_processing: true)
    end
  end

  def to_param
    team_id
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

  def set_team_hash
    self.team_hash = SecureRandom.uuid unless self.team_hash.present?
  end


end
