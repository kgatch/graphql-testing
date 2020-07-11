Feature: GraphQL endpoint testing for a user type from https://graphqlzero.almansi.me/api

	"""
		Apparently https://traveller-core.dev.pelago.co/ doesnt return product data for productId: "eu1y2"
	"""

	@scenario1
	Scenario: Test scenario number 1
		Given I send "application/json"
		When I set the JSON request body to:
		"""
		{
			"operationName": null,
			"variables": {},
			"query": "
				{
					user(id: 1) {
						id
						name
						username
						email
						address {
							street
						}
						phone
						website
					}
					todo(id:1) {
						title
						completed
					}
				}
			"
		}
		"""
		When I send a POST request to "https://graphqlzero.almansi.me/api"
		Then the response status should be "200"
		And the JSON response should follow "features/schema/user_schema.json"
		Then the JSON response should have "data.user.id" of type string and value "1"
		Then the JSON response should have "data.user.name" of type string and value "Leanne Graham"
		Then the JSON response should have "data.todo.completed" of type boolean and value "false"

	@scenario2
	Scenario: Test scenario number 2
		Given I send "application/json"
		When I set the JSON request body to:
		"""
		{
			"operationName": null,
			"variables": {},
			"query": "
				{
					user(id: 1) {
						undefined
						name
						id
					}
				}
			"
		}
		"""
		When I send a POST request to "https://graphqlzero.almansi.me/api"
		Then the response status should be "400"
		Then the JSON response should have "errors[0].message" of type string and special value "Cannot query field "undefined" on type "User"."
		Then the JSON response should have "errors[0].extensions.code" of type string and value "GRAPHQL_VALIDATION_FAILED"

	@scenario3
	Scenario Outline: Test scenario 3
		Given I send "application/json"
		When I set the JSON request body to:
		"""
		{
			"operationName": null,
			"variables": {},
			"query": "
				{
					user(id: 1) {
						id
						name
						username
						email
						address {
							street
						}
						phone
						website
						<fields>
					}
				}
			"
		}
		"""
		When I send a POST request to "https://graphqlzero.almansi.me/api"
		Then the response status should be "200"
		And the JSON response should follow "features/schema/user_schema.json"
		Then the JSON response should have "<json_path>" of type string and value "<value>"

		Examples:
		|fields 			|json_path 					|value 					|
		|id					|data.user.id				|1						|
		|name				|data.user.name				|Leanne Graham			|
		|username			|data.user.username			|Bret					|
		|email				|data.user.email			|Sincere@april.biz		|
		|address { street }	|data.user.address.street	|Kulas Light			|
		|phone				|data.user.phone			|1-770-736-8031 x56442	|
		|website			|data.user.website			|hildegard.org			|

