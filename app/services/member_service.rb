class MemberService < ApplicationService

  def self.cache_all
    offset = 0

    while (find_all( { offset: offset } )[:all].count > 0) do
      result = find_all( { offset: offset } )
      result[:all].each do |member_item|
        member_item.cache!
      end
      offset += result[:all].count
    end
  end


  def self.find_all( args = {} )
    default_args = { offset: 0, limit: 500 }
    args = default_args.merge( args )
    MemberItem.find_all(23632746, args)
  end

end
