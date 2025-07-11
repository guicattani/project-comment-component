class StatusUpdate < Activity
  extend SerializerHelper
  set_required_json_fields %w[from to field]

  def serialize
    "Changed from <b>#{from.humanize}</b> to <b>#{to.humanize}</b>"
  end

  def action
    "updated the #{field}"
  end
end
