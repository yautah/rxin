require 'roxml'
require 'multi_json'


module Rxin
  module Entity

    class Text
      include ROXML
      xml_accessor :content, from: 'Content', cdata: true

      def initialize(content=nil)
        @content = content
      end
    end

    class Image
      include ROXML
      xml_name 'Image'
      xml_accessor :pic_url  , from: 'PicUrl'  , cdata: true
      xml_accessor :media_id , from: 'MediaId' , cdata: true

      def initialize(media_id=nil,pic_url=nil)
        @media_id = media_id
        @pic_url  = pic_url
      end
    end


    class Voice
      include ROXML
      xml_name 'Voice'
      xml_accessor :media_id    , from: 'MediaId'     , cdata: true
      xml_accessor :format      , from: 'Format'      , cdata: true
      xml_accessor :recognition , from: 'Recognition' , cdata: true

      def initialize(media_id=nil,format=nil,recognition=nil)
        @media_id    = media_id
        @format      = format
        @recognition = recognition
      end
    end

    class Video
      include ROXML
      xml_name 'Video'
      xml_accessor :media_id       , from: 'MediaId'      , cdata: true
      xml_accessor :thumb_media_id , from: 'ThumbMediaId' , cdata: true
      xml_accessor :title          , from: 'Title'        , cdata: true
      xml_accessor :description    , from: 'Description'  , cdata: true

      def initialize(media_id=nil, thumb_media_id=nil,title=nil,description=nil)
        @media_id       = media_id
        @thumb_media_id = thumb_media_id
        @title          = title
        @description    = description
      end
    end

    class Location
      include ROXML
      xml_name 'Location'
      xml_accessor :location_x  , from: 'Location_X' , as: Float
      xml_accessor :location_y , from: 'Location_Y' , as: Float
      xml_accessor :scale     , from: 'Scale'      , cdata: true
      xml_accessor :label     , from: 'Label'      , cdata: true

      def initialize(latitude=nil,longitude=nil,scale=nil,label=nil)
        @location_x = latitude
        @location_y = longitude
        @scale      = scale
        @label      = label
      end
    end


    class Link
      include ROXML
      xml_name 'Link'
      xml_accessor :title       , from: 'Title'       , cdata: true
      xml_accessor :description , from: 'Description' , cdata: true
      xml_accessor :url         , from: 'Url'         , cdata: true

      def initialize(title=nil,description=nil,url=nil)
        @title       = title
        @description = description
        @url         = url
      end
    end


    class Music
      include ROXML
      xml_name 'Music'
      xml_accessor :title          , from: 'Title'        , cdata: true
      xml_accessor :description    , from: 'Description'  , cdata: true
      xml_accessor :music_url      , from: 'MusicUrl'     , cdata: true
      xml_accessor :hq_music_url   , from: 'HQMusicUrl'   , cdata: true
      xml_accessor :thumb_media_id , from: 'ThumbMediaId' , cdata: true

      def initialize(title=nil,description=nil,music_url=nil,hq_music_url=nil,thumb_media_id=nil)
        @title          = title
        @description    = description
        @music_url      = music_url
        @hq_music_url   = hq_music_url
        @thumb_media_id = thumb_media_id
      end
    end

    class Article
      include ROXML
      xml_accessor :title         , from: 'Title'        , cdata: true
      xml_accessor :description   , from: 'Description'  , cdata: true
      xml_accessor :pic_url       , from: 'PicUrl'       , cdata: true
      xml_accessor :url           , from: 'Url'          , cdata: true

      def initialize(title=nil,description=nil,pic_url=nil,url=nil)
        @title       = title
        @description = description
        @pic_url     = pic_url
        @url         = url
      end
    end



    # base Message
    class Message
      include ROXML
      xml_name 'xml'
      xml_accessor :to_user        , :from => 'ToUserName'   , :cdata => true
      xml_accessor :from_user      , :from => 'FromUserName' , :cdata => true
      xml_accessor :msg_type       , :from => 'MsgType'      , :cdata => true
      xml_accessor :msg_id         , :from => 'MsgId'        , :as => Integer
      xml_accessor :create_time    , :from => 'CreateTime'   , :as => Integer
      xml_accessor :media_id       , from: 'MediaId'         , cdata: true

      xml_accessor :title          , from: 'Title'           , cdata: true
      xml_accessor :description    , from: 'Description'     , cdata: true

      # text message
      xml_accessor :content        , from: 'Content'         , cdata: true

      # image message
      xml_accessor :pic_url        , from: 'PicUrl'          , cdata: true

      # voice message
      xml_accessor :format         , from: 'Format'          , cdata: true
      xml_accessor :recognition    , from: 'Recognition'     , cdata: true

      #
      # video message
      xml_accessor :thumb_media_id , from: 'ThumbMediaId'    , cdata: true

      # location message
      xml_accessor :location_x       , from: 'Location_X'      , as: Float
      xml_accessor :location_y      , from: 'Location_Y'      , as: Float
      xml_accessor :scale          , from: 'Scale'           , cdata: true
      xml_accessor :label          , from: 'Label'           , cdata: true

      # link message
      xml_accessor :url            , from: 'Url'             , cdata: true

      # music message
      xml_accessor :music_url      , from: 'MusicUrl'        , cdata: true
      xml_accessor :hq_music_url   , from: 'HQMusicUrl'      , cdata: true

      # news message
      xml_accessor :article_count , from: 'ArticleCount' , as: Integer

      # event
      xml_accessor :event     , from: 'Event'     , cdata: true
      xml_accessor :event_key , from: 'EventKey'  , cdata: true
      xml_accessor :ticket    , from: 'Ticket'    , cdata: true
      xml_accessor :latitude  , from: 'Latitude'  , as: Float
      xml_accessor :longitude , from: 'Longitude' , as: Float
      xml_accessor :precision , from: 'Precision' , as: Float


      xml_accessor :image    , as: Image
      xml_accessor :voice    , as: Voice
      xml_accessor :video    , as: Video
      xml_accessor :music    , as: Music
      xml_accessor :location , as: Location
      xml_accessor :link     , as: Link
      xml_accessor :articles , as: [Article]   , in: "Articles" , from: 'Item'

      class << self
        def response(to,from,create_time,msg_obj)
          msg = Message.new
          msg.to_user = to
          msg.from_user = from
          msg.create_time = create_time

          case msg_obj
          when Image,Voice,Video,Music
            msg.msg_type = msg_obj.class.tag_name.downcase
            msg.send("#{msg.msg_type}=",msg_obj)
          when Array
            msg.article_count = msg_obj.size
            msg.msg_type = 'news'
            msg.articles = msg_obj
          when String
            msg.msg_type = 'text'
            msg.content = msg_obj
          else
            raise Exception,'invalid msg body'
          end
          return msg.to_xml
        end

        def reply(to_user, msg_obj)
          msg = Hash.new
          msg['touser'] = to_user
          case msg_obj
          when String
            msg['msgtype'] = 'text'
            msg.update( text: {content: msg_obj})
          when Image
            msg['msgtype'] = 'image'
            msg.update( image: {media_id: msg_obj.media_id})
          when Voice
            msg['msgtype'] = 'voice'
            msg.update( voice: {media_id: msg_obj.media_id})
          when Video
            msg['msgtype'] = 'video'
            msg.update( video: {
              media_id:     msg_obj.media_id,
              title:        msg_obj.title,
              description:  msg_obj.description
            })
          when Music
            msg['msgtype'] = 'music'
            msg.update( music: {
              title:          msg_obj.title,
              description:    msg_obj.description,
              musicurl:       msg_obj.music_url,
              hqmusicurl:     msg_obj.hq_music_url,
              thumb_media_id: msg_obj.thumb_media_id
            })
          when Array
            msg['msgtype'] = 'news'
            items = msg_obj.map do |article|
              {title: article.title, url: article.url, picurl: article.pic_url, description: article.description}
            end
            msg.update( news: {
              articles: items
            })
          end
          return MultiJson.dump(msg)
        end

      end


      private 
      def after_parse
        case msg_type
        when 'image'
          self.image = Image.new(media_id,pic_url)
        when 'voice'
          self.voice = Voice.new(media_id,format,recognition)
        when 'video'
          self.video = Video.new(media_id, thumb_media_id,title,description)
        when 'location'
          self.location = Location.new(location_x,location_y,scale,label)
        when 'link'
          self.link = Link.new(title,description,url)
        end
      end
    end


  end
end
