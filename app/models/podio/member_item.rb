module Podio
  class MemberItem < Podio::Item
    include PodioUtilitiesModule

    def cache!
      member = Member.where(podio_member_id: item_id).first_or_create.refresh(self)
    end

    def cache_attributes
      {
        full_name: self.name,
        first_name: self.first_name,
        last_name: self.last_name,
        podio_member_id: self.item_id,
        status: self.status,
        email: self.email,
        podio_team_id: self.team_id,
        podio_team_name: self.team_name
      }
    end

    def team_id
      team.try(:team_id)
    end

    def team_name
      team.try(:name)
    end

    def team
      Podio::BattleTeam.where("members_array @> ARRAY[?]", self.item_id.to_s).where(team_type: :member).first
    end

    def name
      field_values_by_external_id('full-name')
    end

    def first_name
      field_values_by_external_id('title')
    end

    def last_name
      field_values_by_external_id('last-name')
    end

    def id
      field_values_by_external_id('unique-id')
    end

    def status
      field_values_by_external_id('mn-ic-status')[:text.to_s].downcase
    end

    def email
      found_email = field_values_by_external_id('email')
      if found_email.is_a?(Array)
        found_email.first["value"]
      else
        found_email
      end
    end

  end
end