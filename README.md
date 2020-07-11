# graphql-testing

Apparently https://traveller-core.dev.pelago.co/ doesnt return product data for productId: "eu1y2"
so I used https://graphqlzero.almansi.me/api for the meantime and will just update the tests later on

## Installation
- Install Ruby 2.4.1 via rvm
- Clone the repo
- Install dependencies via `bundle install`
- Run the tests

## Running the Tests
- Run a specific test via path `cucumber features/user.feature`
- Run specific test/s via tag/s `cucumber --tags '@scenario1 or @scenario3'`
- Run all tests except with tag/s `cucumber --tags 'not @scenario1'`
- Run test with verbose logging `cucumber -p verbose --tags '@scenario1'`
- Run test and generate html report. See sample sample_report.html `cucumber --format html --out reports.html`
- Run tests in parallel with thread count input X `parallel_cucumber features -n X`

## Tests Execution Speed
> Single Thread
```shell
18 scenarios (18 passed)
112 steps (112 passed)
0m5.447s
```

> 2 Threads
```shell
9 scenarios (9 passed)
56 steps (56 passed)
0m2.551s

9 scenarios (9 passed)
56 steps (56 passed)
0m2.724s

18 scenarios (18 passed)
112 steps (112 passed)

Took 3 seconds
```