class ApplicationManager
  def initialize
    load_applications
  end

  def select_request_body_by_id(app_id)
    @applications["#{app_id}"]["requestBody"]
  end

  def select_request_headers_by_id(app_id)
    @applications["#{app_id}"]["authorization"]
  end

  private

  def load_applications
    # Loads the application object data from the applications.json which can be used to check api data is correct
    @applications = JSON.parse(File.read(json_file_path('applications.json')).force_encoding('UTF-8'))
  end

  def json_file_path(filename)
    File.expand_path(File.join(File.dirname(__FILE__), '../lib/' + filename))
  end
end