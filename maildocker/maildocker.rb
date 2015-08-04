require_relative 'maildocker/mail'
require_relative 'maildocker/version'

require 'rest-client'

module Maildocker
  class Client
    attr_accessor :api_user, :api_key, :host, :endpoint

    def initialize(params = {})
      @api_key    = params.fetch(:api_key, nil)
      @api_secret = params.fetch(:api_secret, nil)
      @host       = params.fetch(:host, 'https://ecentry.io')
      @endpoint   = params.fetch(:endpoint, '/api/maildocker/' + Maildocker::VERSION + '/mail/')
      @conn       = params.fetch(:conn, create_conn)
      yield self if block_given?
      raise StandardError.new('api_user and api_key are required') unless @api_user && @api_key
    end

    def send(mail)
      @conn[@endpoint].post(mail.to_h) do |response, request, result|
        case response.code.to_s
        when /2\d\d/
          response
        else
          raise StandardError.new(response)
        end
      end
    end

    private

    def create_conn
      @conn = RestClient::Resource.new(@host, @api_key, @api_secret)
    end
  end
end
