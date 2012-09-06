require 'faraday'

class Flechtwerk
  class Neo4jResponseHandler < Faraday::Response::Middleware
    def call(env)

      @app.call(env).on_complete do
        response = env[:response]
        case response.status
        when 200
          # ok
        when 201
          # Created a record
        when 204
          # ok, but no content
        when 400
          raise Flechtwerk::InvalidRequest.new(message: "Invalid data", response: response)
        when 404
          raise Flechtwerk::NotFound.new(message: "Not found", response: response)
        when 409
          raise Flechtwerk::InvalidRequest.new(message: "Node still has relationships", response: response)
        else
          # ???
        end
      end
    end
  end
end