# Ignaz

An API for COVID-19 data in Switzerland

The data is taken from https://github.com/openZH/covid_19

The public API is going to be available here: https://ignaz.herokuapp.com

## Techstack

* Ruby
* Ruby on Rails
* Postgres

## Setup

Install latest Ruby, have Postgres database running:

```sh
bin/setup
```

## Scraper

There's a rake task that downloads and persists data from https://github.com/openZH/covid_19

```sh
bin/rails ignaz:scrape
```

That task runs every 10 minutes on Heroku.

## GraphQL API

TBD

Endpoint: `/graphql`


```gql
query_string = "
  query getCovidCases($region: String) {
    covidCases(abbreviationCantonAndFl: $region) {
      date
      time
      abbreviationCantonAndFl
      ncumulConf
    }
  }
"
```

```ruby
variables = { "region" => "AG" }

result_hash = IgnazSchema.execute(query_string, variables: variables)
```
