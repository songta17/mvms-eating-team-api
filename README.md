# TeamEating

# Introduction
Welcome to the TeamEating API! You can use the API to access to our Bordeaux restaurants list. You can get informations on restaurants, reviews and the team selection.

# DATA
After making bundle install, you can generate the seed to simulate datas.
```rails db:create db:migrate db:seed```

# Authentification
The API needs to make an authentification to access or change datas in the database. The header must contain an API key.

## Signup HTTP Request
  
```POST http://mvms-eating-team-api.herokuapp.com/users```

## Header Parameter
Content-Type application/json

## JSON

```
{ 
  "user":
    {
      "email": "<email>",
      "password": "<password>",
      "password_confirmation": "<password>"
    } 
}
```

## Signin
### HTTP Request
 ```POST http://mvms-eating-team-api.herokuapp.com/users/sign_in```
### Header Parameter
Content-Type application/json
### JSON
```
{
"user": 
  {
    "email": "<email>",
    "password": "<password"
  }
}
```

## Signout 

### HTTP Resquest
 ```DELETE http://mvms-eating-team-api.herokuapp.com/users/sign_out```

### Header Parameter
Authorization Bearer “<token>”

------------------------------------------------

# Restaurant

## Get all Restaurants
This endpoint retrieves all restaurants in the database.

### HTTP Request
 ```GET http://mvms-eating-team-api.herokuapp.com/api/restaurants```
### Query Parameters

| Parameter | Default | Description | 
| ----------- | ----------- | ----------- |
| author | nil | The result will only include restaurant author. |
| offset | 0 | The result will excluse <offset> first result. |
| limilt | 5 | The result will include <limit> results. |
| order | asc | if ‘asc’, the result will be by ascendent order. Possible to chose ‘desc’ for descendant result. |

## Get a specific restaurant
This endpoint retrieves a specific restaurant.
### HTTP Request
 ```GET http://mvms-eating-team-api.herokuapp.com/api/v1/restaurants/ID```
### URL Parameters

| Parameter | Description |
| ----------- | ----------- |
| ID | ID The ID of the restaurant to retrieve |

## Delete a Specific Restaurant

This Endpoint deletes a specific restaurant. Need to be authenticated.

### HTTP Request

```DELETE http://mvms-eating-team-api.herokuapp.com/api/v1/restaurants/ID```

### URL Parameters

| Parameter | Description |
| ----------- | ----------- |
| ID | The ID of the restaurant to delete |

## Create a Restaurants
This endpoint create a restaurant. Need to be authenticated.

### HTTP Request
```POST http://mvms-eating-team-api.herokuapp.com/api/v1/restaurants```

### Header Parameters

| Header | value | Description |
| ----------- | ----------- | ----------- |
| Content-Type  | application/json | In the body, select the json format: <{"restaurant": { "name": “<name_restaurant>”, "user_id": "<user_id>" }}> | 
| Authorization  | Bearer <token> | Token is given in the header when signup or signin. |

## Update a Restaurants
This endpoint create a restaurant. Need to be authenticated.

### HTTP Request
 ```PUT http://mvms-eating-team-api.herokuapp.com/api/v1/restaurants```

### Header Parameters

| Header | value | Description |
| ----------- | ----------- | ----------- |
| Content-Type  | application/json | In the body, select the json format: <{"restaurant": { "name": “<name_restaurant>”, "user_id": "<user_id>" }}> | 
| Authorization  | Bearer <token> | Token is given in the header when signup or signin. |

------------------------------------------------


# Address

## Get all Addresses
This endpoint retrieves all addresses in the database.

### HTTP Request
 ```GET http://mvms-eating-team-api.herokuapp.com/api/addresses```
### Query Parameters

| Parameter | Default | Description | 
| ----------- | ----------- | ----------- |
| country | nil | The result will only include adresses country. |
| zipcode | nil | The result will only include adresses zipcode. |
| town | nil | The result will only include adresses town. |
| offset | 0 | The result will excluse <offset> first result. |
| limilt | 5 | The result will include <limit> results. |
| order | asc | if ‘asc’, the result will be by ascendent order. Possible to chose ‘desc’ for descendant result. |

## Get a specific address

This endpoint retrieves a specific address.

### HTTP Request

 ```GET http://mvms-eating-team-api.herokuapp.com/api/v1/restaurants/ID```
 
### URL Parameters

| Parameter | Description |
| ----------- | ----------- |
| ID | ID The ID of the address to retrieve |

## Delete a Specific Address

This Endpoint deletes a specific restaurant. Need to be authenticated.

### HTTP Request

```DELETE http://mvms-eating-team-api.herokuapp.com/api/v1/addresses/ID```

### URL Parameters

| Parameter | Description |
| ----------- | ----------- |
| ID | The ID of the address to delete |

## Create a Restaurants

This endpoint create an address. Need to be authenticated.

### HTTP Request

```POST http://mvms-eating-team-api.herokuapp.com/api/v1/addresses```

### Header Parameters

| Header | value | Description |
| ----------- | ----------- | ----------- |
| Content-Type  | application/json | In the body, select the json format: <{"address": { "street": “<street>”, "zipcode": “<zipcode>”, "town": “<town>”, "restaurant_id": "<restaurant_id>" }}> | 
| Authorization  | Bearer <token> | Token is given in the header when signup or signin. |

## Update an Address
This endpoint create an address. Need to be authenticated.

### HTTP Request
 ```PUT http://mvms-eating-team-api.herokuapp.com/api/v1/addresses```

### Header Parameters

| Header | value | Description |
| ----------- | ----------- | ----------- |
| Content-Type  | application/json | In the body, select the json format: <{"address": { "street": “<street>”, "zipcode": “<zipcode>”, "town": “<town>”, "restaurant_id": "<restaurant_id>" }}> | 
| Authorization  | Bearer <token> | Token is given in the header when signup or signin. |


------------------------------------------------

# Code Status

The TeamEating Api’s uses the following codes:

## Success

| Success Code | Meaning |
| ----------- | ----------- |
| 200 | Success |
| 201 | Created |
| 204 | Erase successfully |

## Errors

| Error Code | Meaning |
| ----------- | ----------- |
| 400 | Bad Request |
| 401 | Unauthorized |
| 404 | Not found |
| 422 | Unprocessable Entity |


