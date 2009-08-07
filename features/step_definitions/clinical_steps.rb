Given /^I am searching for trials where "([^\"]*)" is "([^\"]*)"$/ do |field, value|
  @params ||= {}

  if value == "true"
    value = true
  elsif value == "false"
    value = false
  end

  @params[field.to_sym] = value
end

Given /^I am searching for trials that have been updated between "([^\"]*)" and "([^\"]*)"$/ do |start_date, end_date|
  dates = [Date.parse(start_date)]
  dates << Date.parse(end_date)

  @params ||= {}
  @params[:updated_at] = dates
end

Given /^I am searching for trials that have been updated after "([^\"]*)"$/ do |date|
  dates = [Date.parse(date)]

  @params ||= {}
  @params[:updated_at] = dates
end

When /^I perform the search$/ do
  @trials = Clinical::Trial.find(:conditions => @params)
end

When /^I perform the extended search$/ do
  @trials = Clinical::Trial.find(:conditions => @params, :extended => true)
end

When /^I attempt to retrieve trial "([^\"]*)"$/ do |id|
  @trial = Clinical::Trial.find_by_id(id)
end

When /^I attempt to retrieve keywords for trial "([^\"]*)"$/ do |id|
  @trial = Clinical::Trial.find_by_id(id)
  @trial.get_metadata
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
        found = true if i.to_s =~ /#{value}/i
      end
      found.should be_true
    else
      result.to_s.should =~ /#{value}/i
    end
  end
end

Then /^I should get a trial$/ do
  @trial.should_not be_nil
end

Then /^the trial should have an? "([^\"]*)" of "([^\"]*)"$/ do |field, value|
  @trial.send(field).to_s.should eql(value)
end

Then /^the trial should have (an\s)?"([^\"]*)" like "([^\"]*)"$/ do |an, field, value|
  @trial.send(field).to_s.should =~ /#{Regexp.escape(value)}/
end

Then /^I should get trials where "([^\"]*)" is greater than "([^\"]*)"$/ do |arg1, arg2|
  pending
end

Then /^I should get trials where "([^\"]*)" is greater than or equal to "([^\"]*)"$/ do |attr, date|
  @trials.each do |t|
    assert t.send(attr) >= Date.parse(date), 
      "#{t.send(attr)} is not >= #{Date.parse(date)}"
  end 
end

Then /^I should get trials where "([^\"]*)" is less than or equal to "([^\"]*)"$/ do |attr, date|
  @trials.each do |t|
    assert t.send(attr) <= Date.parse(date), 
      "#{t.send(attr)} is not <= #{Date.parse(date)}"
  end 
end


Then /^I should not get a trial$/ do
  @trial.should be_nil
end


Then /^I should get trials where "([^\"]*)" is between "([^\"]*)" and "([^\"]*)"$/ do |attr, start_date, end_date|
  end

