# This class is responsible for syncing data from Podio to the application's database.
# It initializes the Podio client, caches all data, and marks it as unprocessed.
# It also provides methods to mark data as to be processed, delete all data, and get the services for teams and members.
class PodioSyncService < ApplicationService

  # Initializes the Podio client with the API key, API secret, and authentication credentials.
  def initialize
    podio_client = Podio.setup(:api_key => Rails.application.credentials.dig(:podio_api_key), :api_secret => Rails.application.credentials.dig(:podio_api_secret))
    Podio.client.authenticate_with_credentials(Rails.application.credentials.dig(:podio_auth_login), Rails.application.credentials.dig(:podio_auth_password))
    @initialized = true
  end

  # Caches all data by initializing if not already initialized, marking as unprocessed, and caching all services.
  def cache_all
    initialize unless @initialized.present?
    mark_unprocessed!
    services.each{ |service| service.cache_all }
  end

  # Marks all data as to be processed by calling the set_all_to_be_processed method on each service.
  def mark_to_be_processed!
    services.each{ |service| service.set_all_to_be_processed! }
  end

  private

  # Returns an array of services for teams and members.
  def services
    [team_service, member_service]
  end

  # Deletes all data by deleting all teams and members.
  def delete_all
    Team.delete_all
    Member.delete_all
  end

  # Returns a new instance of the TeamService class.
  def team_service
    @team_service ||= TeamService.new
  end

  # Returns a new instance of the MemberService class.
  def member_service
    @member_service ||= MemberService.new
  end
end
