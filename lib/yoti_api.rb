class YotiApi
  # This class should deal with any CRUD operations for testing the YOTI Api. Currently there is only update
  # but it could be used to create, read or delete objects.


  def initialize(yoti_api_url)
    @path = "#{yoti_api_url}/apps/"
  end

  def update(app_id, params)
    [:request_headers, :request_body].each { |key| params.fetch(key)} # Checks for the presence of request_headers or request_body in the params otherwise the below put request would be unable to work
    HTTParty.put(@path + app_id, query: params[:request_body], headers: params[:request_headers])
  end

  def add_permissions_to_request_body(request_body, permissions)
    request_body.merge!(permissions: permissions)
  end
end