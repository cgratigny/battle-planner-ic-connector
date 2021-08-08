class MongoidRecord

  def firestore
    @firestore ||= ApplicationService.new.firestore
  end

end
