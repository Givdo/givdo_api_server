Givdo API v1.0
==============

Documentation for Givdo API v1.0.


## Schema

This version of the API follows the [JSON API Specification](http://jsonapi.org/format/).
Please check the documentation for more details.


## Authentication

Requests that require authentication will return `403 Forbidden` when a valid
token isn't present. Tokens must the specified as the value for `Authorization`
header, on every request.

    Authorization: Token token=OAUTH-TOKEN


## Pagination

Requests that return multiple items will be paginated to 30 itens by default. You
can specify further pages with the `?page` parameter. You can also set a custom
page size with the `?per_page` parameter.

    curl 'https://givdo-prod.herokuapp.com/api/v1/friends?page=2&per_page=100'


## Errors

Errors follows the **JSON API Specification**. Errors can be uniquely identified
by its `code` field. Some error codes are:

    VALIDATION_ERROR
    PARAM_MISSING
    SAVE_FAILED
    FORBIDDEN
    RECORD_NOT_FOUND
    INTERNAL_SERVER_ERROR
    GAMES_QUOTA_EXCEEDED

For more details about errors see `lib/givdo/error_codes.rb` and `lib/givdo/exceptions.rb`.
