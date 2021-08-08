class ApplicationDecorator < SimpleDelegator

  def initialize(model)
    @model = model

    instance_variable_set("@#{sanitize_model_class(model.class.name)}".to_sym, model)
    super(instance_variable_get("@#{sanitize_model_class(model.class.name)}".to_sym))
  end

  def sanitize_model_class(model_class)
    model_class.gsub(":", "")
  end

end
