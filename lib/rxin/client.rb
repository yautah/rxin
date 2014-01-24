require 'faraday'
require 'multi_json'

module Rxin
  class Client
    attr_accessor :app_id, :app_secret, :uri, :media_uri, :access_token, :expires_at

    def initialize(app_id, app_secret)
      @app_id = app_id
      @app_secret = app_secret
      @uri = 'https://api.weixin.qq.com/cgi-bin'
      @media_uri = 'http://file.api.weixin.qq.com/cgi-bin'

      #@uri = 'http://192.168.1.2:4000/weixin/fake/'
      #@media_uri = 'http://file.api.weixin.qq.com/cgi-bin/'

      @conn = Faraday.new(:url => @uri) do |faraday|
        faraday.request  :url_encoded             # form-encode POST params
        faraday.response :logger                  # log requests to STDOUT
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end
    end

    # get access_token by appid & app_secret
    # https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=APPID&secret=APPSECRET
    # returns: {"access_token":"ACCESS_TOKEN","expires_in":7200}
    def get_access_token
      result_json = {}
      begin
        res = @conn.get 'token', {grant_type: 'client_credential', appid: @app_id, secret: @app_secret }
        result_json = MultiJson.load(res.body)
      rescue => e
        
      else
        @access_token = result_json['access_token']
        @expires_at   = Time.now + result_json['expires_in'].to_i-300
      end
      result_json
    end

    #check access_token valid or not
    def is_access_token_valid?
      return @access_token.present? && Time.now<@expires_at
    end

    def ensure_token!
      unless is_access_token_valid?
        get_access_token
      end
    end

    def get(url, params={})
      ensure_token!
      @conn.get do |req|
        req.url url
        req.params = params
        req.params[:access_token] = @access_token
        req.options[:timeout] = 5           # open/read timeout in seconds
        req.options[:open_timeout] = 5      # connection open timeout in seconds
      end
    end

    def post(url,params={},body)
      ensure_token!
      @conn.post do |req|
        req.url url
        req.params = params
        req.params[:access_token] = @access_token
        req.body = body.to_s if body.present?
      end
    end

    # send message
    # method: post
    # https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token=ACCESS_TOKEN
    def send_message(json_msg)
      res = post("message/custom/send",{},json_msg.to_s)
      return MultiJson.load(res.body)
    end

    # get user list
    # method: get
    # https://api.weixin.qq.com/cgi-bin/user/get?access_token=ACCESS_TOKEN&next_openid=NEXT_OPENID
    def get_user_list(next_openid=nil)
      params = {}
      params.update(next_openid: next_openid) if next_openid.present?
      res = get("user/get",params)
      return MultiJson.load(res.body)
    end

    # get user info
    # method: get
    # https://api.weixin.qq.com/cgi-bin/user/info?access_token=ACCESS_TOKEN&openid=OPENID
    def get_user_info(openid)
      params = {}
      params.update(openid: openid)
      res = get("user/info",params)
      return MultiJson.load(res.body)
    end

    # create menu
    # method: post
    #  https://api.weixin.qq.com/cgi-bin/menu/create?access_token=ACCESS_TOKEN
    def create_menu(menu_body)
      res = post("menu/create",{},menu_body)
      return MultiJson.load(res.body)
    end

    # get menu info
    # method: get
    # https://api.weixin.qq.com/cgi-bin/menu/get?access_token=ACCESS_TOKEN
    def get_menu()
      res = get("menu/get")
      return MultiJson.load(res.body)
    end


    # delete menu
    # method: get
    # https://api.weixin.qq.com/cgi-bin/menu/delete?access_token=ACCESS_TOKEN
    def delete_menu()
      res = get("menu/delete")
      return MultiJson.load(res.body)
    end


  end
end
