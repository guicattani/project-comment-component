class Comment < Activity
  def serialize
    content
  end
end
