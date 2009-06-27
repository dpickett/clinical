Given /^I am searching for trials where "([^\"]*)" is "([^\"]*)"$/ do |field, value|
  @params ||= {}

  if value == "true"
    value = true
  elsif value == "false"
    value = false
  end

  @params[field.to_sym] = value
end

When /^I perform the search$/ do
  @trials = Clinical::Trial.find(:conditions => @params)
end

When /^I perform the extended search$/ do
  @trials = Clinical::Trial.find(:conditions => @params, :extended => true)
end

Then /^I should get trials that are (not )?"([^\"]*)"$/ do |not_included, field|
  if not_included
    result = false
  else
    result = true
  end

  @trials.each do |trial|
    trial.send(field + "?").should(eql(result))
  end
end

Then /^I should get trials where the "([^\"]*)" contains "([^\"]*)"$/ do |field, value|
  @trials.each do |trial|
    item_values = []
    result = trial.send(field)
    if result.is_a?(Array)
      found = false
      result.each do |i|
        found = true if i =~ /#{value}/i
      end
      found.should be_true
    else
      result.should =~ /#{value}/i
    end
  end
end

