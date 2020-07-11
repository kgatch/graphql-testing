require 'cucumber-api'


Given(/^I send "(.*?)"$/) do |content_type|
	@headers = {
		:'Content-Type' => %/#{content_type}/
	}
end

When(/^I set the JSON request body to:$/) do |body|
  body.gsub!(/\s+/, " ")
  @body = JSON.dump(JSON.parse(resolve(body)))
end

Then(/^the JSON response should have "([^"]*)" of type (string) and special value "(.*?)"$/) do |json_path, type, value|
  @response.get_as_type_and_check_value json_path, type, resolve(value)
end