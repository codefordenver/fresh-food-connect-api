# fresh-food-connect-api

[![Build Status](https://travis-ci.org/codefordenver/fresh-food-connect-api.svg?branch=master)](https://travis-ci.org/codefordenver/fresh-food-connect-api)



## Development

### Running the Fresh Food Connect API application

This application uses the [Thin Ruby web server](http://code.macournoyer.com/thin/usage/). To Start the applicaton, simple type the following from the comandline.

        bundle exec thin start
        
## Services

### Donations

**Preconditions**
* All Authentication headers must be present in the request
* For PUT/POST calls, should contain a supported Content-Type for content negotiation`

#### Getting donations for a given user at a given location
**This resource is only authorized for donors and admins**

Request:

    GET http://{host}:{port}/api/{version}/users/{user_id}/locations/{location_id}/donations
    
Response:
    HTTP 200 OKAY
    
    [
        {
            id: Int,
            size: String (small | medium | large),
            location_id: Int,
            user_id: Int,
            created_at: DateTime,
            updated_at: DateTime
        },
        ...
    ]
    
### Creating a new Donation as a user for a given location

Any invalid request body parameters will result in a `422 Unprocessable Entity` along with an errors object detailing the invalid entity data.

Request:

    POST http://{host}:{port}/api/{version}/users/{user_id}/locations/{location_id}/donations
    
    {
        size: INT (small = 1 | medium = 2 | large = 3),
        comments: String (max length 255 characters)
        
    }
    
 Response:
    HTTP 201 CREATED
    
    [
        {
            id: Int,
            size: String (small | medium | large),
            location_id: Int,
            user_id: Int,
            created_at: DateTime,
            updated_at: DateTime
        },
        ...
    ] 
    

### Updating a given Resource
**This route is authorized only for the owner of the Donation resource and administrators**

This route will return a `204 No Content` on successful updates because it assumes the Client has the most up-to-date representation of the Donation resource. Any invalid request body parameters will result in a `422 Unprocessable Entity` along with an errors object detailing the invalid entity data.

Request:

    PUT http://{host}:{port}/api/{version}/users/{user_id}/locations/{location_id}/donations/{id}
    
    {
        size: INT (small = 1 | medium = 2 | large = 3),
        comments: String (max length 255 characters)
        
    }
    
 Response:
    HTTP 204 NO CONTENT
    
### Querying Donations for a given date range
**This route is authorized for Administrators only**

Request:

    GET http://{host}:{port}/api/{version}/users/donations?from=DateTime&to=DateTime
    
Response:
    HTTP 200 OKAY
    
    [
        {
            id: Int,
            size: String (small | medium | large),
            location_id: Int,
            user_id: Int,
            created_at: DateTime,
            updated_at: DateTime
        },
        ...
    ]
