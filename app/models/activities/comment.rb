class Comment < Activity
  extend SerializerHelper
  set_required_json_fields %w[text]

  def serialize
    text
  end

  def action
    "commented"
  end
end
