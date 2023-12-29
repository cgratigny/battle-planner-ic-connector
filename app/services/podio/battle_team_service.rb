class Podio::BattleTeamService < ApplicationService

  def self.initialize
    podio_sync_service
  end

  def cache_all
    find_all[:all].each do |team_item|
      team_item.cache!
    end
  end

  def find_all( args = {} )
    args.merge!( { offset: 0, limit: 500 } )
    Podio::TeamItem.find_all(23713788, args)
  end

  def set_all_to_be_processed!
    Podio::BattleTeam.set_all_to_be_processed!
  end

  def name
    self.title
  end

  def podio_sync_service
    @podio_sync_service ||= PodioSyncService.new
  end

end
