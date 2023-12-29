class ApplicationRecord < ActiveRecord::Base  
  primary_abstract_class

  def firestore
    @firestore ||= ApplicationService.new.firestore
  end

end
