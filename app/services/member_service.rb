class MemberService < ApplicationService

  def initialize
    podio_sync_service
  end

  def cache_all
    offset = 0

    puts " = Cache Member Items"
    loop do
      result = find_all(offset: offset)
    
      break if result[:all].empty?
    
      result[:all].each do |member_item|
        puts " - MemberItem##{member_item.id}-#{member_item.email}"
        member_item.cache!
      end
    
      offset += result[:all].count
    end
    
    delete_unprocessed!
  end

  def delete_unprocessed!
    Podio::Member.delete_unprocessed!
  end

  def set_all_to_be_processed!
    Podio::Member.set_all_to_be_processed!
  end

  def find_all( given_args = {} )
    args = { offset: 0, limit: 100 }.merge(given_args)
    Podio::MemberItem.find_all(23632746, args)
  end

  def podio_sync_service
    @podio_sync_service ||= PodioSyncService.new
  end

end
