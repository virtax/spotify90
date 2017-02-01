module Requests
  module JsonHelpers
    def json_response
      JSON.parse(response.body)
    end

    def post_json(path, params = {})
      post path,
        params: params.to_json,
        headers: header
    end

    def get_json(path, params = {})
      get path,
        params: params,
        headers: header
    end

    def put_json(path, params = {})
      put path,
        params: params.to_json,
        headers: header
    end

    private

    def header
      {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
    end
  end
end
