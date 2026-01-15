# Customer Invitation API

  A Ruby on Rails API that processes customer records from a file and returns customers located within 100 km of the Mumbai office, based on geographical distance calculations.


# Features

  Accepts customer data as a JSON Lines (.txt) file

  Filters customers within 100 km of the Mumbai office

  Returns sorted customer invitees

  Fully tested using RSpec

  API documented using Swagger / OpenAPI


# Tech Stack

  Ruby 3.x

  Rails 7.x (API mode)

  RSpec for testing

  Swagger / OpenAPI for API documentation


# Setting Up the Application

  Ruby 3.x

  Rails 7.x

  Bundler

  Git


# Clone the repository

  git clone <repository-url>
  cd <project-name>


# Install the dependencies

  bundle install


# Run the server

  rails server


# CURL to verify the API

  curl -X POST \
    -F "file=@test/fixtures/files/customers.txt" \
    http://localhost:3000/api/v1/customers/invitees


# Running Test cases 
  <!-- 3 test files for each service, demonstrates distance calculation, file parsing, and filtering logic.  -->
  bundle exec rspec