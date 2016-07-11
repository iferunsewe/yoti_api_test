Given(/^an application in the Yoti API has the id (.*)$/)do |app_id|
  @app_id = app_id
end

Given(/^a client wants to send a request with a valid request body$/)do
  @request_body = @yoti_api.add_permissions_to_request_body(@application_manager.select_request_body_by_id(@app_id), @permissions)
end

Given(/^a client wants to send a request with (valid|invalid) authorization$/)do |validity|
  invalid_authorization = {"login"=>"user12@email.com", "password"=>"jklm5678"}
  @request_headers = validity == 'valid' ? @application_manager.select_request_headers_by_id(@app_id) : invalid_authorization
end

Given(/^a client wants update the permissions on the application to (.*)$/)do |permissions|
  @permissions = permissions.split(",")
end

Then(/^the client should receive the response status code (.*)$/)do |status_code|
  expect(@response.status_code).to eq(status_code), "The client did not recieve the correct response status code #{status_code}"
end

Given(/^a client wants to send a request with a missing field (.*)$/)do |missing_field|
  @request_body = @application_manager.select_request_body_by_id(@app_id).delete(missing_field)
end

Given(/^a client wants to send a request with an invalid field (.*)$/)do |invalid_field|
  selected_request_body = @application_manager.select_request_body_by_id(@app_id)
  @request_body = selected_request_body["#{invalid_field}"] = 'abcdefgh'
end

Given(/^the client has sent a request body to update (.*) for the application to (.*)$/)do |key, value|
  selected_request_body = @application_manager.select_request_body_by_id(@app_id)
  @request_body = selected_request_body.merge!("#{key}" => value)
end

When(/^the client sends a http request to update the application$/)do
  @response = @yoti_api.update(@app_id, {request_body: @request_body, request_headers: @request_headers})
end

Given(/^the client wants to send a request with no authorization$/)do
  @request_headers = {}
end

But(/^an application does not exist for the provided app ID$/)do
  expect(@response.body.include?('application does not exist')).to be(true), "The client did not recieve the correct response body"
end

But(/^there is an internal service error$/)do
  expect(@response.body.include?('internal service error')).to be(true), "The client did not recieve the correct response body"
end