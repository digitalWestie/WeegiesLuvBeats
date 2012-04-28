#coding: utf-8
require 'csv'
require 'iconv'

namespace :weegie do

  desc "Imports from CSV"
  task :import_csv => :environment do |t, args|
    
    #tracks = CSV.read("#{Rails.root}/app/assets/chs2012.csv")

    tracks = CSV.read("#{Rails.root}/app/assets/chs2012b.csv", :col_sep => ";", :force_quotes => true)
    for track in tracks
      artist = Artist.find_or_create_by_name(Iconv.iconv('utf-8', 'iso8859-1', track[0]).first)
      Track.find_or_create_by_name_and_artist_id(Iconv.iconv('utf-8', 'iso8859-1', track[1]).first, artist.id, 
        :album => Iconv.iconv('utf-8', 'iso8859-1', track[2]).first,
        :genre => Iconv.iconv('utf-8', 'iso8859-1', track[3]).first,
        :playlist => Iconv.iconv('utf-8', 'iso8859-1', track[4]).first,
        :server_location => Iconv.iconv('utf-8', 'iso8859-1', track[5]).first,
        :plays => Iconv.iconv('utf-8', 'iso8859-1', track[6]).first,
        :mood => Iconv.iconv('utf-8', 'iso8859-1', track[7]).first,
        :record_label => Iconv.iconv('utf-8', 'iso8859-1', track[8]).first,
        :texture => Iconv.iconv('utf-8', 'iso8859-1', track[9]).first,
        :duration => Iconv.iconv('utf-8', 'iso8859-1', track[10]).first)
    end    


=begin
    artist_index = tracks.first.index 'artist'
    track_index = tracks.first.index 'track'
    album_index = tracks.first.index 'album'
    genre_index = tracks.first.index 'genre'
    playlist_index = tracks.first.index 'playlist'
    server_location_index = tracks.first.index 'server_location'
    plays_index = tracks.first.index 'plays'
    mood_index = tracks.first.index 'mood'
    record_label_index = tracks.first.index 'record_label'
    texture_index = tracks.first.index 'texture'
    length_index = tracks.first.index 'length'

    tracks.delete_at(0) # get rid of format row in array
    #artists = tracks.collect { |t| t[artist_index] }
    #artists.each { |a| Artist.find_or_create_by_name(a) }

    for track in tracks

      artist_name   = ""
      track         = ""
      album         = ""
      genre         = ""
      playlist      = ""
      server_location = ""
      plays         = ""
      mood          = ""
      record_label  = ""
      texture       = ""
      length        = ""

      artist_name   = track[artist_index] unless track[artist_index].nil?
      track         = track[track_index] unless track[track_index].nil?
      album         = track[album_index] unless track[track_index].nil?
      genre         = track[genre_index] unless track[genre_index].nil?
      playlist      = track[playlist_index] unless track[playlist_index].nil?
      server_location = track[server_location_index] unless track[server_location_index].nil?
      plays         = track[plays_index] unless track[plays_index].nil?
      mood          = track[mood_index] unless track[mood_index].nil?
      record_label  = track[record_label_index] unless track[record_label_index].nil?
      texture       = track[texture_index] unless track[texture_index].nil?
      length        = track[length_index] unless track[length_index].nil?

      artist = Artist.find_or_create_by_name(artist_name)
      Track.find_or_create_by_name(track, :artist_id => artist.id, 
        :album => album,
        :genre => genre,
        :playlist => playlist,
        :server_location => server_location,
        :plays => plays,
        :mood => mood,
        :record_label => record_label,
        :texture => texture,
        :duration => length)
    end
=end

  end
end

