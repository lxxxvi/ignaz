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

### Examples

**All**

```graphql
{
  covidCases {
    date
    time
    abbreviationCantonAndFl
    ncumulTested
    ndeltaTested
    ncumulConf
    ndeltaConf
    ncumulHosp
    ndeltaHosp
    ncumulIcu
    ndeltaIcu
    ncumulVent
    ndeltaVent
    ncumulReleased
    ndeltaReleased
    ncumulDeceased
    ndeltaDeceased
    ninstantIcuIntub
    source
  }
}
```

**Filtered by region**

```graphql
{
  covidCases(abbreviationCantonAndFl: "ZG") {
    date
    time
    abbreviationCantonAndFl
    ncumulTested
    ndeltaTested
    ncumulConf
    ndeltaConf
    ncumulHosp
    ndeltaHosp
    ncumulIcu
    ndeltaIcu
    ncumulVent
    ndeltaVent
    ncumulReleased
    ndeltaReleased
    ncumulDeceased
    ndeltaDeceased
    ninstantIcuIntub
    source
  }
}
```
