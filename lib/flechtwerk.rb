require "flechtwerk/version"

require 'faraday'
require 'faraday_middleware'

require 'flechtwerk/exceptions'
require 'flechtwerk/neo4j_response_handler'

class Flechtwerk
  RESET_PLUGIN_URL = 'https://github.com/jexp/neo4j-clean-remote-db-addon'

  def server_settings
    @server_settings ||= self.get('/')
  end

  def root
    root_id = extract_id(server_settings['reference_node'])
    @root ||= find_node(root_id)
  end

  def find_node(id)
    node_id = extract_id(id)
    get "/node/#{node_id}"
  end

  def create_node(attributes = {})
    post '/node', attributes.reject{ |k,v| v.nil? }
  end

  def update_node(id, attributes)
    node_id = extract_id(id)
    put "/node/#{node_id}/properties", attributes.reject{ |k,v| v.nil? }
  end

  def update_node_property(id, property, value)
    node_id = extract_id(id)
    put "/node/#{node_id}/properties/#{property}", value.to_s
  end

  def delete_node(id)
    node_id = extract_id(id)
    delete "/node/#{node_id}"
  end

  def delete_node_property(id, property)
    node_id = extract_id(id)
    delete "/node/#{node_id}/properties/#{property}"
  end

  def reset_database!
    delete("/cleandb/secret-key")
    true
  end

  def extract_id(id)
    case id
    when Hash
      id["self"].split('/').last.to_i
    when String
      id.split('/').last.to_i
    when Fixnum
      id
    else
      raise 'Could not extract id'
    end
  end

  def exec_cypher(query, params = {})
    post('/cypher', { 'query' => query, params => params })
  end

  protected

  def url
    "http://localhost:7474"
  end

  def connection
    @connection ||= Faraday.new(:url => url, :headers => { 'Content-Type' => 'application/json' }) do |faraday|
      faraday.use FaradayMiddleware::EncodeJson
      faraday.use FaradayMiddleware::ParseJson, :content_type => /\bjson$/
      faraday.use Flechtwerk::Neo4jResponseHandler
      # faraday.response :logger # log requests to STDOUT
      faraday.adapter Faraday.default_adapter
    end
  end

  def post(path, params = nil)
    response = connection.post "/db/data#{path}", params
    response.body
  end

  def get(path, params = nil)
    response = connection.get "/db/data#{path}", params
    response.body
  end

  def put(path, params = nil)
    response = connection.put "/db/data#{path}", params
    response.body
  end

  def delete(path, params = nil)
    response = connection.delete "/db/data#{path}", params
    response.body
  end

end