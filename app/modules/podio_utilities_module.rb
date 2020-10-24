module PodioUtilitiesModule

  def field_values_by_external_id(external_id, options = {})
    if self.fields.present?
      field = self.fields.find { |field| field['external_id'] == external_id }
      if field
        values = field['values']
        if options[:simple] || values.count == 1
          values.first[:value.to_s]
        else
          values
        end
      else
        nil
      end
    else
      nil
    end
  end

end
