@travel_product_2
Feature: GraphQL testing for a travel product from https://traveller-core.dev.pelago.co/graphql?
	"""
		Test Scenarios
		- Query all fields of the travel product
		- Query partial fields of the travel product
		- Query fields of the travel product one by one

		Validations:
		- Response schema
		- Successful response status
		- Field types and values
		- Fields and values in the response based on query
		- No additional fields will be returned by the backend
	"""

	@scenario1
	Scenario: Query all fields of the travel product
		Given I send "application/json"
		And I set the JSON request body to:
		"""
		{
			"variables":null,
			"operationName":null,
			"query":"{
				product(productId:\"pci2f\"){
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
		Then the JSON response should follow "features/schema/travel_product_schema.json"
		Then the JSON response should have "data.product.productId" of type string and value "pci2f"
		Then the JSON response should have "data.product.productName" of type string and value "GX-5 Extreme Swing"
		Then the JSON response should have "data.product.destinationId" of type string and value "dest_singapore"
		Then the JSON response should have "data.product.mediaData" of type array
		Then the JSON response should have "data.product.cancellationType" of type string and value "ALLOW_CANCELLATION"
		Then the JSON response should have "data.product.cancellationWindow" of type numeric_string and value "24"
		Then the JSON response should have required key "data.product.minGroupSize" of type numeric or null
		Then the JSON response should have "data.product.duration" of type string and value "3 Hours"
		Then the JSON response should have "data.product.openDateTicket" of type boolean and value "false"
		Then the JSON response should have "data.product.collectPhysicalTicket" of type boolean and value "true"
		Then the JSON response should have "data.product.confirmationType" of type string and value "MANUAL"
		Then the JSON response should have "data.product.voucherType" of type string and value "PELAGO"
		Then the JSON response should have "data.product.guideLanguages" of type string and value "English"
		Then the JSON response should have "data.product.priceRangeFrom" of type numeric_string and value "45.2"
		Then the JSON response should have "data.product.priceRangeTo" of type numeric_string and value "88.88"
		Then the JSON response should have "data.product.latitude" of type string and value "1.222993"
		Then the JSON response should have "data.product.longitude" of type string and value "103.854226"
		Then the JSON response should have "data.product.address" of type string and value "#01-330 Suntec City"
		Then the JSON response should have "data.product.content" of type object

	@scenario2
	Scenario: Query partial fields of the travel product
		Given I send "application/json"
		And I set the JSON request body to:
		"""
		{
			"variables":null,
			"operationName":null,
			"query":"{
				product(productId:\"pci2f\"){
					productId
					destinationId
					cancellationType
					minGroupSize
					openDateTicket
					confirmationType
					guideLanguages
					priceRangeTo
					longitude
					content
				}
			}"
		}
		"""
		When I send a POST request to "https://traveller-core.dev.pelago.co/graphql?"
		Then the response status should be "200"
		Then the JSON response should follow "features/schema/travel_product_schema.json"
		Then the JSON response should have "data.product.productId" of type string and value "pci2f"
		Then the JSON response should have "data.product.destinationId" of type string and value "dest_singapore"
		Then the JSON response should have "data.product.cancellationType" of type string and value "ALLOW_CANCELLATION"
		Then the JSON response should have required key "data.product.minGroupSize" of type numeric or null
		Then the JSON response should have "data.product.openDateTicket" of type boolean and value "false"
		Then the JSON response should have "data.product.confirmationType" of type string and value "MANUAL"
		Then the JSON response should have "data.product.guideLanguages" of type string and value "English"
		Then the JSON response should have "data.product.priceRangeTo" of type numeric_string and value "88.88"
		Then the JSON response should have "data.product.longitude" of type string and value "103.854226"
		Then the JSON response should have "data.product.content" of type object

	@scenario3
	Scenario Outline: Query fields of the travel product one by one
		Given I send "application/json"
		And I set the JSON request body to:
		"""
		{
			"variables":null,
			"operationName":null,
			"query":"{
				product(productId:\"pci2f\"){
					<fields>
				}
			}"
		}
		"""
		When I send a POST request to "https://traveller-core.dev.pelago.co/graphql?"
		Then the response status should be "200"
		Then the JSON response should follow "features/schema/travel_product_schema.json"
		Then the JSON response should have "<json_path>" of type <type> and value "<value>"

		Examples:
		|fields 				|json_path 								|type 			|value						|
		|productId				|data.product.productId					|string			|pci2f						|
		|productName			|data.product.productName				|string			|GX-5 Extreme Swing			|
		|destinationId			|data.product.destinationId				|string			|dest_singapore				|
		|cancellationType		|data.product.cancellationType			|string			|ALLOW_CANCELLATION			|
		|cancellationWindow		|data.product.cancellationWindow		|numeric_string	|24							|
		|duration				|data.product.duration					|string			|3 Hours					|
		|openDateTicket			|data.product.openDateTicket			|boolean		|false						|
		|collectPhysicalTicket	|data.product.collectPhysicalTicket		|boolean		|true						|
		|confirmationType		|data.product.confirmationType			|string			|MANUAL						|
		|voucherType			|data.product.voucherType				|string			|PELAGO						|
		|guideLanguages			|data.product.guideLanguages			|string			|English					|
		|priceRangeFrom			|data.product.priceRangeFrom			|numeric_string	|45.2						|
		|priceRangeTo			|data.product.priceRangeTo				|numeric_string	|88.88						|
		|latitude				|data.product.latitude					|string			|1.222993					|
		|longitude				|data.product.longitude					|string			|103.854226					|
		|address				|data.product.address					|string			|#01-330 Suntec City		|
