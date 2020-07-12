require 'cucumber-api'
require 'hashdiff'


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

Then(/^the JSON response should have "([^"]*)" of type (array) and value "([^"]*)"$/) do |json_path, type, value|
	@response.get_as_type_and_check_value json_path, type, resolve(value)
end

Then(/^the JSON response should have "([^"]*)" of type (array|object)$/) do |json_path, type|
	@response.get_as_type json_path, type
end

Then(/^the JSON response is equal to:$/) do |json|
	hash_response = JSON.parse(@response)
	hash_to_compare = JSON.parse(resolve(json))

	if HashDiff.diff(hash_response, hash_to_compare) != []
		raise "object:\n#{hash_to_compare.to_json}\n not equal object:\n#{hash_response.to_json}"
	end
end
