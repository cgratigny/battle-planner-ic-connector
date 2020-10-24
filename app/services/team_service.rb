class TeamService < ApplicationService

  def self.cache_all
    find_all[:all].each do |team_item|
      team_item.cache!
    end
  end

  def self.find_all( args = {} )
    args.merge!( { offset: 0, limit: 500 } )
    TeamItem.find_all(23713788, args)
  end

  def name
    self.title
  end

end
