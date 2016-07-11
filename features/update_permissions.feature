Feature: Update permissions
  As a client
  I want to update the permissions of an application
  So that an application has the correct permissions

  Background:
    Given an application in the Yoti API has the id 1

  Scenario: Successful update
    And a client wants update the permissions on the application to A, C
    And a client wants to send a request with a valid request body
    And a client wants to send a request with valid authorization
    When the client sends a http request to update the application
    Then the client should receive the response status code 200

  Scenario Outline: Missing request body field
    And a client wants to send a request with a missing field <key>
    And a client wants to send a request with valid authorization
    When the client sends a http request to update the application
    Then the client should receive the response status code 400

  Examples: Missing field
    | key         |
    | name        |
    | domain      |
    | permissions |

  Scenario Outline: Incorrect request body field
    And a client wants to send a request with an invalid field <key>
    And a client wants to send a request with valid authorization
    When the client sends a http request to update the application
    Then the client should receive the response status code 400

  Examples:
    | key          |
    | namee        |
    | domaain      |
    | permisssions |

  Scenario Outline: Update fields other than permissions
    And the client has sent a request body to update <key> for the application to <value>
    And a client wants to send a request with valid authorization
    When the client sends a http request to update the application
    Then the client should receive the response status code 403

  Examples:
      | key    | value                   |
      | name   | MyApplication           |
      | domain | https://my.domain.co.uk |

  Scenario: No Authorization header
    And a client wants update the permissions on the application to A, C
    And a client wants to send a request with a valid request body
    And the client wants to send a request with no authorization
    When the client sends a http request to update the application
    Then the client should receive the response status code 403

  Scenario: User does not exist
    And a client wants update the permissions on the application to A, C
    And a client wants to send a request with a valid request body
    And a client wants to send a request with invalid authorization
    When the client sends a http request to update the application
    Then the client should receive the response status code 403

  Scenario: Application does not exist for provided app ID
    And a client wants update the permissions on the application to A, C
    And a client wants to send a request with a valid request body
    And a client wants to send a request with valid authorization
    When the client sends a http request to update the application
    But an application does not exist for the provided app ID
    Then the client should receive the response status code 404

  Scenario: Internal service error
    And a client wants update the permissions on the application to A, C
    And a client wants to send a request with a valid request body
    And a client wants to send a request with valid authorization
    When the client sends a http request to update the application
    But there is an internal service error
    Then the client should receive the response status code 500
