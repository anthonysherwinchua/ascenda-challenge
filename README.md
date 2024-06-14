# Links
- [Project setup](#project-setup)
- [Merge Data](#merge-data)
- [Parse and Clean Data](#parse-and-clean-data)
- [Selecting the best data](#selecting-the-best-data)
- [API Endpoint](#api-endpoint)

# Project Setup
##### Prerequisites

The project expects following tools installed on the system.

- Git
- Postgres
- Ruby [3.0.0](https://www.ruby-lang.org/en/news/2020/12/25/ruby-3-0-0-released/)
- Rails [7.1.3.4](https://guides.rubyonrails.org/index.html)

##### 1. Check out the repository

```bash
git clone https://github.com/anthonysherwinchua/ascenda-challenge
```

##### 2. Setup rails secret

- copy the content (minus the auto-generated secret_key_base) of `config/credentials.yml.sample` and paste it in the next command
- Run the following command in the terminal
```
EDITOR=vim rails credentials:edit
```
- update the database password

##### 3. Update database password

  - rails credentials:edit
  - update the `db` > `password`

  note: update the file `config/database.yml` according to your postgres setup

##### 4. Run the usual Rails command
Setup ruby version and gemset with your preferred ruby and gem manager

```
  bundle install
  bundle exec rails db:create
  bundle exec rails db:migrate
```

##### 5. Run post-deployment tasks

  - run `bundle exec rails after_party:run`

[Back to top](#links)

# Merge Data
### how to pull and merge data?
run the following command in the terminal
```
bundle exec rails sidekiq
```
this will wait and process the background jobs

in another terminal, open up rails console and input the following
```
SupplierDataJob.perform_async
```

Going back to the `sidekiq` terminal, it should start logging some information

### about the code

- `SupplierDataJob` is in `app/sidekiq/supplier_data_job.rb`
  - it iterates through the suppliers and then creates another job to process it
- `HotelDataJob` is in `app/sidekiq/hotel_data_job.rb`
  - it calls `HotelData` to start fetching and merging the hotels data

[Back to top](#links)

# Parse and Clean Data
### about the code
`HotelData` uses the supplier's ORM
  - it uses ORM pattern to map out different supplier to a common database structure

Example of attribute parsed by the ORM:
| Acme  | Paperflies | Patagonia |
| --- | --- | --- |
| DestinationId | destination_id | destination|

These maps to a database column `destination_id`

After parsing the data and mapping it, the base class (in which ORMs inherits), will clean the data, and return it in a hash. This returned hash can be directly used to create a Hotel record

ORMs can be found in `app/services/orm/`

[Back to top](#links)

# Selecting the best data
after `HotelData` receives the hash, it will use the matchers. The matchers determines the best data possible for each field. e.g. Name is determined by longest string. It also combines array and hashes together and removes blank data. e.g. images, and booking_conditions

The matchers can be found in `app/services/matchers`

[Back to top](#links)

# API Endpoint
### how to run the server
run the following command in the terminal
```
bundle exec rails s
```

### what's the endpoint?
On the browser, type in the following:
```
http://localhost:3000/api/hotels
```

### what filters can be used?
Here are the (AND) filters that can be used:
- `search` - A string to search the hotel name. e.g. "Beach Villas", "InterContinental", "Shinjuku"
- `hotels` - Array of hotel_ids. e.g. "iJhz", "SjyX", "f8c9"
- `destination` - A destination_id. e.g. 5432, 1122
- `page` - Page. defaults to 1
- `per` - Records per page. defaults to 5

### about the code
`HotelPresenter` can be found in `app/presenters/hotels_presenter.rb`
  - it queries all the hotels
  - it uses `HotelDecorator` to change some information accordingly. e.g. titleizing the name
  - it also uses low-level caching for the result based on the parameter given

JSON response is described in `app/views/api/hotels/index.json.jbuilder`

[Back to top](#links)