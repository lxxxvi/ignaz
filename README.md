# Ignaz

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
