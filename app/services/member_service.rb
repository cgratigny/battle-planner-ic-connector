class MemberService < ApplicationService

  def initialize
    podio_sync_service
  end

  def cache_all
    offset = 0

    while (find_all( { offset: offset } )[:all].count > 0) do
      result = find_all( { offset: offset } )
      result[:all].each do |member_item|
        ap member_item
        member_item.cache!
      end
      offset += result[:all].count
    end
  end

  def set_all_to_be_processed!
    Member.set_all_to_be_processed!
  end

  def find_all( args = {} )
    default_args = { offset: 0, limit: 50 }
    args = default_args.merge( args )
    MemberItem.find_all(23632746, args)
  end

  def podio_sync_service
    @podio_sync_service ||= PodioSyncService.new
  end

end
