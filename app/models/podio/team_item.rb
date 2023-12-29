module Podio
  class TeamItem < Podio::Item
    include PodioUtilitiesModule

    def cache!
      team = Podio::BattleTeam.where(team_id: item_id).first_or_create
      team.update(name: self.name, members_array: self.member_ids, team_type: team_type, updated_at: Time.zone.now)
    end

    def name
      self.title
    end

    def team_type
      begin
        find_array_by_external_id('tm-admin-level').first["value"]["text"].downcase
      rescue
      end
    end

    def type
      app["config"]["type"]
    end

    def member_ids
      all_members.map{ |member| member["value"]["item_id"] }
    end

    def all_members
      find_members + find_leader + find_xo
    end

    def find_members
      find_array_by_external_id('team-members')
    end

    def find_leader
      find_array_by_external_id('bt-leader')
    end

    def find_xo
      find_array_by_external_id('xos')
    end

    def find_array_by_external_id(external_id)
      found_items = field_values_by_external_id(external_id)
      if found_items.is_a?(Hash)
        [{ "value" => found_items }]
      elsif found_items.is_a?(Array)
        found_items
      elsif found_items.nil?
        []
      end
    end

  end
end