Given /^I am searching for trials where "([^\"]*)" is "([^\"]*)"$/ do |field, value|
  @params ||= {}
  @params[field.to_sym] = value
end

When /^I perform the search$/ do
  @trials = Clinical::Trial.find(:conditions => @params)
end

Then /^I should get trials with the "([^\"]*)" of "([^\"]*)" or "([^\"]*)"$/ do |field, value, value_2|
  @trials.each do |trial|
    [value, value_2].should include(trial.send(field.to_sym).to_s)
  end
end

