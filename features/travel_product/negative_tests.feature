@travel_product_negative_tests @negative_tests
Feature: GraphQL negative testing for a travel product from https://traveller-core.dev.pelago.co/graphql?
	"""
		Test Scenarios
		- Query for a non existing travel product
		- Query for a non existing field for a travel product

		Validations:
		- Error message
		- Field types and values
		- Failed response status
	"""

	@scenario4
	Scenario: Query for a non existing travel product
		Given I send "application/json"
		And I set the JSON request body to:
		"""
		{
			"variables":null,
			"operationName":null,
			"query":"{
				product(productId:\"abcde\"){
					productId
					productName
					destinationId
					mediaData
					cancellationType
					cancellationWindow
					minGroupSize
					duration
					openDateTicket
					collectPhysicalTicket
					confirmationType
					voucherType
					guideLanguages
					priceRangeFrom
					priceRangeTo
					latitude
					longitude
					address
					content
				}
			}"
		}
		"""
		When I send a POST request to "https://traveller-core.dev.pelago.co/graphql?"
		Then the response status should be "200"
		Then the JSON response is equal to:
		"""
		{
			"data": {
				"product": null
			}
		}
		"""

	@scenario5
	Scenario: Query for a non existing field for a travel product
		Given I send "application/json"
		And I set the JSON request body to:
		"""
		{
			"variables":null,
			"operationName":null,
			"query":"{
				product(productId:\"pewuq\"){
					missing
				}
			}"
		}
		"""
		When I send a POST request to "https://traveller-core.dev.pelago.co/graphql?"
		Then the response status should be "400"
		Then the JSON response should have "errors[0].message" of type string and special value "Cannot query field "missing" on type "Product"."
