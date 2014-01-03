require 'roxml'
require 'multi_json'

module Rxin
  module Entity
    class Text
      include ROXML
      xml_accessor :content, from: 'Content', cdata: true
    end

    # <xml>
    #     <ToUserName><![CDATA[toUser]]></ToUserName>
    #     <FromUserName><![CDATA[fromUser]]></FromUserName> 
    #     <CreateTime>1348831860</CreateTime>
    #     <MsgType><![CDATA[text]]></MsgType>
    #     <Content><![CDATA[this is a test]]></Content>
    #     <MsgId>1234567890123456</MsgId>
    # </xml>
    class TextMessage < Message
      xml_accessor :content, from: 'Content', cdata: true

      def initialize
        super
        @msg_type = 'text'
      end
      
    end

    # <xml>
    #   <ToUserName><![CDATA[toUser]]></ToUserName>
    #   <FromUserName><![CDATA[fromUser]]></FromUserName>
    #   <CreateTime>12345678</CreateTime>
    #   <MsgType><![CDATA[text]]></MsgType>
    #   <Content><![CDATA[你好]]></Content>
    # </xml>
    class TextReply < TextMessage 
      def to_json
        MultiJson.dump(to_hash.update( text: {content: content}))
      end
    end

  end
end
