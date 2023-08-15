[![RSpec](https://github.com/TalariaSoftware/somebadapples/actions/workflows/rspec.yml/badge.svg)](https://github.com/TalariaSoftware/somebadapples/actions/workflows/rspec.yml)

[![Rubocop](https://github.com/TalariaSoftware/somebadapples/actions/workflows/rubocop.yml/badge.svg)](https://github.com/TalariaSoftware/somebadapples/actions/workflows/rubocop.yml)
[![HAML-Lint](https://github.com/TalariaSoftware/somebadapples/actions/workflows/haml_lint.yml/badge.svg)](https://github.com/TalariaSoftware/somebadapples/actions/workflows/haml_lint.yml)

[![Brakeman](https://github.com/TalariaSoftware/somebadapples/actions/workflows/brakeman.yml/badge.svg)](https://github.com/TalariaSoftware/somebadapples/actions/workflows/brakeman.yml)
[![Bundler audit](https://github.com/TalariaSoftware/somebadapples/actions/workflows/bundler-audit.yml/badge.svg)](https://github.com/TalariaSoftware/somebadapples/actions/workflows/bundler-audit.yml)
[![CodeQL analysis](https://github.com/TalariaSoftware/somebadapples/actions/workflows/codeql-analysis.yml/badge.svg)](https://github.com/TalariaSoftware/somebadapples/actions/workflows/codeql-analysis.yml)
[![License finder](https://github.com/TalariaSoftware/somebadapples/actions/workflows/license-finder.yml/badge.svg)](https://github.com/TalariaSoftware/somebadapples/actions/workflows/license-finder.yml)

[![Maintainability](https://api.codeclimate.com/v1/badges/ceed13ca74e86e5a4f9c/maintainability)](https://codeclimate.com/github/TalariaSoftware/somebadapples/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/ceed13ca74e86e5a4f9c/test_coverage)](https://codeclimate.com/github/TalariaSoftware/somebadapples/test_coverage)

# README

[Some Bad Apples](https://somebadapples.org) attempts to provide a searchable
interface to identify some of the bad apples in policing agencies.

## Data sources

### POST Roster

The list of officers and their positions was acquired by [Police
Files](https://policefiles.org/2022/12/24/half-million-cops/) via a public records request to the [California Commission on Peace Officer Standards and Traning](https://post.ca.gov)

The raw data is located at `public/data/us/ca/post-roster-2022.csv`.

Import it to your environment with the command `./bin/rails runner "::Us::Ca::PostRoster2022::Entry.import"`. On a development environment, creating all 400,000+ entries takes about 30 seconds.

## Development

### Setup

1. Install Ruby (version in `.ruby-version`)
2. Install PosgreSQL
2. Install bundler: `gem install bundler`
3. Install gems: `bundle`
4. Setup database: `rake db:setup`
5. Install and start ElasticSearch
  Via Homebrew:
    ```sh
    brew install elastic/tap/elasticsearch-full
    brew services start elasticsearch-full
    ```

### Tests

Run all automated tests: `rake`

Individual tests

- [Rubocop](https://rubocop.org) (ruby linting): `rubocop`
- [HAML Lint](https://github.com/sds/haml-lint#haml-lint): `haml-lint`
- [RSpec](https://rspec.info) (executable specifications): `rspec`
- [Rails Best Practices](https://rails-bestpractices.com) (Rails-specific linting): `rail_best_practices`
- [License Finder](https://github.com/pivotal/LicenseFinder) (library license checking): `license_finder`
- [Brakeman](https://brakemanscanner.org) (security testing via static analysis): `brakeman`
- [bundler-audit](https://github.com/rubysec/bundler-audit#readme) (Find vulnerable ruby libraries) `bundler-audit`

Code Coverage is provided by
[SimpleCov.](https://github.com/simplecov-ruby/simplecov#simplecov----) After
running `rspec` you can view the code coverage report in your default browser
with `open coverage/index.html`

### Import POST data

The POST data is a collection of over 400,000 officer positions. The CSV file is
in `app/public/data`. After changing the way the data is imported you may want
to reimport it.

#### Development

```sh
rake db:reset import_post_roster create_post_agencies create_post_officers create_post_records
```

#### Production

```
heroku maintenance:on
heroku pg:reset
heroku run -s standard-2x rake db:schema:load import_post_roster create_post_agencies create_post_officers create_post_records
heroku maintenance:off
```

### Reindex for search

After loading new data the search database has to be re-indexed.

```sh
bin/rails runner "[Agency, Document, Incident, Officer].each(&:reindex)"
```
