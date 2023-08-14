class MemberService < ApplicationService

  def initialize
    podio_sync_service
  end

  def cache_all
    offset = 0

    loop do
      result = find_all(offset: offset)
    
      break if result[:all].empty?
    
      result[:all].each do |member_item|
        ap member_item
        member_item.cache!
      end
    
      offset += result[:all].count
    end
    
    delete_unprocessed!
  end

  def delete_unprocessed!
    Member.delete_unprocessed!
  end

  def set_all_to_be_processed!
    Member.set_all_to_be_processed!
  end

  def find_all( given_args = {} )
    args = { offset: 0, limit: 500 }.merge(given_args)
    ap args
    MemberItem.find_all(23632746, args)
  end

  def podio_sync_service
    @podio_sync_service ||= PodioSyncService.new
  end

end
