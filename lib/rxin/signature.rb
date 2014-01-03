module Rxin
  class Signature
    attr_accessor :signature, :app_token, :timestamp, :nonce 

    def initialize(signature, app_token, timestamp, nonce)
      @signature = signature
      @app_token = app_token
      @timestamp = timestamp
      @nonce = nonce
    end

    def is_valid?
      param_array = [@app_token, @timestamp, @nonce]
      sign = Digest::SHA1.hexdigest( param_array.sort.join )
      return sign.eql? @signature
    end

  end
end
