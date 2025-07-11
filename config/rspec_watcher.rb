RSpecWatcher.configure do
  watch "spec", only: /_spec\.rb\z/ do |modified, added, _removed|
    modified + added
  end
end
