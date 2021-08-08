class PodioSyncService < ApplicationService

  def self.initialize
    podio_client = Podio.setup(:api_key => Rails.application.credentials.dig(:podio_api_key), :api_secret => Rails.application.credentials.dig(:podio_api_secret))
    Podio.client.authenticate_with_credentials(Rails.application.credentials.dig(:podio_auth_login), Rails.application.credentials.dig(:podio_auth_password))
    @initialized = true
  end

  def self.cache_all
    initialize unless @initialized.present?
    TeamService.cache_all
    MemberService.cache_all
  end

  def self.clear_all
    Team.delete_all
    Member.delete_all
  end
end
