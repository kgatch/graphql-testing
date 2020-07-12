# graphql-testing
-----

## Problem and Solution
Problem: The server and the client are communicating via graphQL request and response. We need to come up with test scenarios against the
system to guarantee high standard and reliability when it goes live. The tests are also needed to be automated to reduce the software release
cycle. The main goal is to release new features in production fast without compromising the quality of the software product.

Solution: Test cases were thought of carefully and automated via cucumber. Cucumber is a test automation tool known for its simplicity
and flexibility. It offers support for managing test cases by modules such that you can specifically define which tests to run in a
given situation using "tags". It has a wide range of validation capabilities for APIs such as schema, data type, values, response code, etc. 
It also supports parallel execution of tests to massively reduce runtime.

## Test Cases
- [x] Make sure all the available fields of an existing travel product can be queried all at once
- [x] Make sure partial list of all available fields of an existing travel product can be queried
- [x] Make sure every single field of an existing travel product can be queried individually
- [x] Verify the schema of the travel product response
- [x] Verify the data types of each available field of an existing travel product
- [x] Verify the values of each available field of an existing travel product
- [x] Validate the status code of the response - both successful and not
- [x] Validate the response for querying a non existing travel product
- [x] Validate the response for querying a non existing field of an existing travel product
- [x] Run the tests in parallel to reduce runtime
- [ ] Query all combinations of available fields of an existing travel product and validate response. 
This is probably an overkill to test the endpoint but still worth it as parallel execution of tests is already 
supported thus runtime will still not take that long.

## Installation
- Install Ruby 2.4.1 via rvm
- Clone the repo
- Install bundler gem via `gem install bundler`
- Install dependencies via `bundle install`
- Run the tests

## Running the Tests via Command Line
- Run a specific test via path `cucumber features/travel_product/travel_product_1.feature`
- Run specific test/s via tag/s `cucumber --tags '@scenario1 or @scenario3'`
- Run all tests except with tag/s `cucumber --tags 'not @scenario1'`
- Run test with verbose logging `cucumber -p verbose --tags '@scenario1'`
- Run test and generate html report. See sample sample_report.html `cucumber --format html --out reports.html`
- Run tests in parallel with thread count input X `parallel_cucumber features -n X`

## Tests Execution Speed - Single and Multi Thread
> Single Thread = 3.76 seconds
```shell
54 scenarios (54 passed)
405 steps (405 passed)
0m3.761s
```

> 3 Threads = 1.14 seconds
```shell
18 scenarios (18 passed)
135 steps (135 passed)
0m1.134s

18 scenarios (18 passed)
135 steps (135 passed)
0m1.134s

18 scenarios (18 passed)
135 steps (135 passed)
0m1.141s

54 scenarios (54 passed)
405 steps (405 passed)

Took 2 seconds
```

## Other Concerns
- travel product with productId "eu1y2" doesnt really exist thus I initially implemented my tests against https://graphqlzero.almansi.me/api.
See initial commit.
- some of the fields are either different or not totally available. I used "mediaData" and "cancellationWindow" rather than 
"mediaLinks" and "cancellationCutoff". Then I removed "priceAdultFrom" and "priceChildFrom" as they don't really exist in the
travel product which I ended up using.
