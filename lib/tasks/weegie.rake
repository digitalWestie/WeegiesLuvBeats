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

  end

  desc "Set has_entry variable"
  task :check_entries => :environment do |t, args|
    artists = Artist.all
    for artist in artists

        artist.has_entry = true
        artist.has_entry = false if Rockstar::Artist.new(artist.name, :include_info => true).playcount.nil?
        artist.save

    end

    tracks = Track.all
    for track in tracks

        track.has_entry = true
        track.has_entry = false if Rockstar::Track.new(track.artist.name, track.name, :include_info => true).playcount.nil?
        track.save

    end
  end

  desc "get artist tags"
  task :get_artist_tags => :environment do |t, args|

    artists = Artist.have_data.all
    for artist in artists
      ts = Rockstar::Artist.new(artist.name, :include_info => true).top_tags
      unless artist.tags.size.eql?(ts.size)
        puts "Adding #{ts.size} tags"
        for tag in ts
          unless tag.name.size > 254 or tag.url.size > 254
            t = Tag.find_or_create_by_name(tag.name, :url => tag.url)
            AssociatedTag.find_or_create_by_artist_id_and_tag_id(artist.id, t.id, :count => tag.count)
          end
        end
      end
    end

  end

  desc "get track tags"
  task :get_track_tags => :environment do |t, args|

    tracks = Track.have_data.all

    for track in tracks
      if track.tags.empty?
        puts "Track #{tracks.find_index(track)} of #{tracks.size}"
        ts = Rockstar::Track.new(track.artist.name, track.name, :include_info => true).tags
        unless track.tags.size.eql?(ts.size)
          for tag in ts
            unless tag.name.size > 254 or tag.url.size > 254
              t = Tag.find_or_create_by_name(tag.name, :url => tag.url)
              AssociatedTag.find_or_create_by_track_id_and_tag_id(track.id, t.id, :count => tag.count)
            end
          end
        end
      end
    end

  end

end
