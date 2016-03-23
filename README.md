# fresh-food-connect-api

[![Build Status](https://travis-ci.org/codefordenver/fresh-food-connect-api.svg?branch=master)](https://travis-ci.org/codefordenver/fresh-food-connect-api)

## Getting Started

After you have cloned this repo, run this setup script to set up your machine
with the necessary dependencies to run and test this app:

    % ./bin/setup

It assumes you have a machine equipped with Ruby, Postgres, etc. If not, set up
your machine with [this script].

[this script]: https://github.com/thoughtbot/laptop

After setting up, you can run the application:

    % rails server

## Development

### Running the Fresh Food Connect API application

This application uses the [Thin Ruby web server](http://code.macournoyer.com/thin/usage/). To Start the applicaton, simple type the following from the comandline.

        bundle exec thin start

Thin doesn't necessarily show you logs that are helpful in development, so it might be useful to use the normal Rails server instead:

        bundle exec rails s

## Services

**Preconditions**
* All Authentication headers must be present in the request
* For PUT/POST calls, should contain a supported Content-Type for content negotiation`

### Pickup Schedules

#### Creating a Pickup Schedule
**This resource is only authorized for admins**

Request:

        POST http://{host}:{port}/api/{version}/admin/pickup_schedules

        {
          zip_code: String,
          notification_text: Text,
          notification_time: String,
          pickup_date_range_end: Date,
          pickup_date_range_start: Date,
          pickup_time_range_end: String,
          pickup_time_range_start: String,
        }

Response:
        HTTP 201 CREATED

        [
            {
                id: Int,
                notification_text: Text,
                notification_time: String,
                pickup_date_range_end: Date,
                pickup_date_range_start: Date,
                pickup_time_range_end: String,
                pickup_time_range_start: String,
            },
            ...
        ]

### Donations

#### Getting donations for a given user at a given location
**This resource is only authorized for donors and admins**

Request:

        GET http://{host}:{port}/api/{version}/users/{user_id}/donations

Response:
        HTTP 200 OKAY

        [
            {
                id: Int,
                size: Int (0..3)
                location_id: Int,
                user_id: Int,
                location_id: Int,
                created_at: DateTime,
                updated_at: DateTime
            },
            ...
        ]

### Creating a new Donation as a user for a given location

Any invalid request body parameters will result in a `422 Unprocessable Entity` along with an errors object detailing the invalid entity data.

Request:

        POST http://{host}:{port}/api/{version}/users/{user_id}/donations?location_id={location_id}

        {
          size: INT (none = 0 | small = 1 | medium = 2 | large = 3),
          comments: String (max length 255 characters)
        }

 Response:

        HTTP 201 CREATED

        [
            {
                id: Int,
                size: Int (0..3)
                location_id: Int,
                user_id: Int,
                created_at: DateTime,
                updated_at: DateTime
            },
            ...
        ]


### Updating a given user's Donation
**This route is authorized only for the owner of the Donation resource and administrators**

This route will return a `204 No Content` on successful updates because it assumes the Client has the most up-to-date representation of the Donation resource. Any invalid request body parameters will result in a `422 Unprocessable Entity` along with an errors object detailing the invalid entity data.

Request:

        PUT http://{host}:{port}/api/{version}/users/{user_id}/donations/{id}

        {
          size: INT (none = 0 | small = 1 | medium = 2 | large = 3),
          comments: String (max length 255 characters)
        }

 Response:

        HTTP 200 OK

        {
            id: Int,
            size: Int (0..3)
            location_id: Int,
            user_id: Int,
            created_at: DateTime,
            updated_at: DateTime
        }

### Querying Donations for a given date range
**This route is authorized for Administrators only**

Request:

        GET http://{host}:{port}/api/{version}/users/donations?from=DateTime&to=DateTime

Response:

        HTTP 200 OK

        [
            {
                id: Int,
                size: Int (0..3)
                location_id: Int,
                user_id: Int,
                created_at: DateTime,
                updated_at: DateTime
            },
            ...
        ]

### Locations

#### Fetching locations associated with a given user

Returns a collection of Location resources for a given user.

Request:

        GET http://{host}:{port}/api/{version}/users/{user_id}/locations

Response:

        HTTP: 200 OK

        [
            {
                id: Int,
                user_id: Int,
                address: String,
                city: String,
                zipcode: String,
                latitude: Float,
                longitude: Float,
                pickup_date: Date,
                comments: String,
                extra: String,
                created_at: DateTime,
                updated_at: DateTime
            },
            { ... },
            { ... },
            ...
        ]

#### Viewing a specific location for a given user

Request:

        GET http://{host}:{port}/api/{version}/users/{user_id}/locations/{location_id}

Response:

        HTTP 200 OK

        {
            id: Int,
            user_id: Int,
            address: String,
            city: String,
            zipcode: String,
            latitude: Float,
            longitude: Float,
            pickup_date: Date,
            comments: String,
            extra: String,
            created_at: DateTime,
            updated_at: DateTime
        }

#### Created a new location for a given user

Request:

        POST http://{host}:{port}/api/{version}/users/{user_id}/locations

        {
            address: String,
            city: String,
            zipcode: String,
            latitude: Float,
            longitude: Float,
            pickup_date: Date,
            comments: String,
            extra: String,
        }

Response:

        HTTP 201 CREATED

        {
            id: Int,
            user_id: Int,
            address: String,
            city: String,
            zipcode: String,
            latitude: Float,
            longitude: Float,
            pickup_date: Date,
            comments: String,
            extra: String,
            created_at: DateTime,
            updated_at: DateTime
        }

#### Updating an existing location for a given user

        PUT http://{host}:{port}/api/{version}/users/{user_id}/locations/{location_id}

        {
            address: String,
            city: String,
            zipcode: String,
            latitude: Float,
            longitude: Float,
            pickup_date: Date,
            comments: String,
            extra: String,
        }

Response:

        HTTP 200 OKAY

        {
            id: Int,
            user_id: Int,
            address: String,
            city: String,
            zipcode: String,
            latitude: Float,
            longitude: Float,
            pickup_date: Date,
            comments: String,
            extra: String,
            created_at: DateTime,
            updated_at: DateTime
        }

#### Deleting a user's location

Request:

        DELETE http://{host}:{port}/api/{version}/users/{user_id}/locations/{location_id}

Response:

        HTTP 204 NO CONTENT


#### Fetching the locations of all users:
This route requests the request to be made from a user with the `Admin` role, otherwise the service call will result in a `403 Unauthorized`.

Request:

        GET http://{host}:{port}/api/{version}/locations

Response:

        HTTP 200 OK

        {
            locations: [
                {
                    id: Int,
                    user_id: Int,
                    address: String,
                    city: String,
                    zipcode: String,
                    latitude: Float,
                    longitude: Float,
                    pickup_date: Date,
                    comments: String,
                    extra: String,
                    created_at: DateTime,
                    updated_at: DateTime
                },
                ...,
                ...
            ],
            users: [
                {
                    id: Int,
                    first: String,
                    last: String,
                    email: String,
                    role: String,
                    phone: String
                },
                ...,
                ...
            ]
        }
