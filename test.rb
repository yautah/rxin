# -*- encoding : utf-8 -*-
require 'rxin'



m = Rxin::Entity::Message.new
puts '-----Text original Message--------------------------'
m.to_user_name = 'hhh'
m.from_user_name ='xxxx'
m.create_time = 32423423
m.msg_id = 23343343
m.msg_type = 'text'
m.content = 'haha'
msg = m.to_xml(:encoding => 'UTF-8', :indent => 0, :save_with => 0)
puts msg

m.msg_type = nil

puts '-----Text positive Message--------------------------'
puts Rxin::Entity::Message.response('asdfasdf','asfasdfasdf',11111111,'position response')


puts '-----Text positive Message--------------------------'
puts Rxin::Entity::Message.reply('asdfasdf','position response'),"\n"
#mm = Rxin.parse(msg.to_s)
#puts mm


m = Rxin::Entity::Message.new
puts 'Image original Message--------------------------'
m.to_user_name = 'hhh'
m.from_user_name ='xxxx'
m.create_time = 32423423
m.msg_id = 23343343
m.msg_type = 'image'
m.pic_url = 'pic_url'
m.media_id = 'a2234234234'
msg = m.to_xml(:encoding => 'UTF-8', :indent => 0, :save_with => 0)
puts msg

mm = Rxin::Entity::Message.from_xml(msg.to_s)

m.pic_url = nil
m.media_id = nil
m.msg_type = nil


puts '-----Image positive Message--------------------------'
puts Rxin::Entity::Message.response('asdfasdf','asfasdfasdf',11111111,mm.image)
puts '-----Image positive Message--------------------------'
puts Rxin::Entity::Message.reply('asdfasdf',mm.image),"\n"




m = Rxin::Entity::Message.new
puts '----- Voice--------------------------'
m.to_user_name = 'hhh'
m.from_user_name ='xxxx'
m.create_time = 32423423
m.msg_id = 23343343
m.msg_type = 'voice'
m.format = 'mp4'
m.media_id = 'a2234234234'
msg = m.to_xml(:encoding => 'UTF-8', :indent => 0, :save_with => 0)
puts msg

vv = Rxin::Entity::Message.from_xml(msg.to_s)
puts '-----Voice positive Message--------------------------'
puts Rxin::Entity::Message.response('asdfasdf','asfasdfasdf',11111111,vv.voice)
puts '-----Voice positive Message--------------------------'
puts Rxin::Entity::Message.reply('asdfasdf',vv.voice),"\n"




m = Rxin::Entity::Message.new
puts '------Video Message--------------------------'
m.to_user_name = 'hhh'
m.from_user_name ='xxxx'
m.create_time = 32423423
m.msg_id = 23343343
m.msg_type = 'video'
m.media_id = 'a2234234234'
m.thumb_media_id = 'a2234234234'
msg = m.to_xml(:encoding => 'UTF-8', :indent => 0, :save_with => 0)
puts msg
vv = Rxin::Entity::Message.from_xml(msg.to_s)
vv.video.thumb_media_id = nil
vv.video.title = 'video title'
vv.video.description = 'video desc'
puts '-----Voice positive Message--------------------------'
puts Rxin::Entity::Message.response('asdfasdf','asfasdfasdf',11111111,vv.video)
puts '-----Voice positive Message--------------------------'
puts Rxin::Entity::Message.reply('asdfasdf',vv.video),"\n"



m = Rxin::Entity::Message.new

puts '-----Location Message --------------------------'
m.to_user_name = 'hhh'
m.from_user_name ='xxxx'
m.create_time = 32423423
m.location_x = 23.134521
m.location_y = 113.358803
m.scale = 20
m.msg_type = 'location'
m.label = '北京科技大学'
msg = m.to_xml(:encoding => 'UTF-8', :indent => 0, :save_with => 0)
puts msg

vv = Rxin::Entity::Message.from_xml(msg.to_s)
puts vv.location.location_x, vv.location.location_y


m = Rxin::Entity::Message.new
puts 'Link Message --------------------------'
m.to_user_name = 'hhh'
m.from_user_name ='xxxx'
m.create_time = 32423423
m.title = 'title'
m.msg_type = 'link'
m.url = 'http://www.g.cn'
m.description = 'http://www.g.cn'
msg = m.to_xml(:encoding => 'UTF-8', :indent => 0, :save_with => 0)
puts msg

vv = Rxin::Entity::Message.from_xml(msg.to_s)
puts vv.link.title, vv.link.url

music = Rxin::Entity::Music.new
puts '-----Music Message --------------------------'
music.title = 'music title'
music.description = 'music description'
music.music_url = 'music url'
music.hq_music_url = 'music hq url'
music.thumb_media_id = 'music thumb id'


puts '-----Music positive Message--------------------------'
puts Rxin::Entity::Message.response('asdfasdf','asfasdfasdf',11111111,music)
puts '-----Music positive Message--------------------------'
puts Rxin::Entity::Message.reply('asdfasdf',music),"\n"



a1 = Rxin::Entity::Article.new
a1.title = 'title a'
a1.url = 'url 1'
a1.pic_url = 'pic_url 1'
a1.description = 'desc a'

a2 = Rxin::Entity::Article.new
a2.title = 'title 2'
a2.url = 'url 2'
a2.pic_url = 'pic_url 2'
a2.description = 'desc 2'

articles = []
articles << a1
articles << a2

puts '-----news positive Message--------------------------'
puts Rxin::Entity::Message.response('asdfasdf','asfasdfasdf',11111111,articles)
puts '-----news positive Message--------------------------'
puts Rxin::Entity::Message.reply('asdfasdf',articles),"\n"
