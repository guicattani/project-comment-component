class StatusUpdateCreator
  attr_reader :attrs, :changed, :model, :user

  def self.create(attrs, changed, model, user)
    new(attrs, changed, model, user).create
  end

  def initialize(attrs, changed, model, user)
    @attrs = attrs
    @changed = changed
    @model = model
    @user = user
  end

  def create
    changed.each do |change|
      StatusUpdate.create(from: attrs[change.first],
                          to: change.second,
                          field: change.first,
                          activitable_type: model.class,
                          activitable: model,
                          user: user)
    end
  end
end
