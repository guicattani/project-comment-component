module SerializerHelper
  attr_reader :required_json_fields

  def set_required_json_fields(keys)
    @required_json_fields = keys
    store_accessor :content, @required_json_fields
    validates_presence_of @required_json_fields
  end
end
