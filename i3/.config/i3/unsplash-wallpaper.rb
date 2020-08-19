#!/usr/bin/env ruby

require 'digest'
require 'open-uri'
require 'tmpdir'

SEED = Digest::SHA256.hexdigest('unsplash-wallpaper-v1').freeze

def save_to_tempfile(url)
  fullpath = File.join(Dir.tmpdir, SEED)
  return File.open(fullpath) if File.file?(fullpath)

  URI.open(url) do |image|
    content = image.read
    File.open(fullpath, 'wb+') do |f|
      f.binmode
      f.write(content)
      f
    end
  end
end

f = save_to_tempfile "https://source.unsplash.com/featured/3840x2160/daily/?cat"
`feh --bg-scale #{f.path}`
