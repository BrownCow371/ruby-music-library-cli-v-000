Skip to content
Features
Business
Explore
Marketplace
Pricing

Search

Sign in or Sign up
0 0 1,275 BrownCow371/ruby-music-library-cli-v-000
forked from learn-co-students/ruby-music-library-cli-v-000
 Code  Pull requests 0  Projects 0  Insights
Join GitHub today
GitHub is home to over 28 million developers working together to host and review code, manage projects, and build software together.

ruby-music-library-cli-v-000/lib/musiclibrarycontroller.rb
421acff  15 hours ago
@BrownCow371 BrownCow371 012 tests passing
     
96 lines (81 sloc)  2.75 KB
require 'pry'
class MusicLibraryController

  attr_accessor :path, :library

  def initialize(path = "./db/mp3s")
      self.path = path
      self.library = MusicImporter.new(path)
      self.library.import
  end

  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"

    poss_answer = {'list songs' => "list_songs",
      'list artists'=> "list_artists",
      'list genres' => "list_genres",
      'list artist'=> "list_songs_by_artist",
      'list genre' => "list_songs_by_genre",
      'play song' => "play_song"}

    answer = gets

      while answer != 'exit'
        if poss_answer[answer] == nil
          puts "What would you like to do?"
          answer = gets
        else
          self.send(poss_answer[answer])
          puts "What would you like to do?"
          answer = gets
        end
      end
    end

  def list_songs
    # Song.all.sort_by{|song| song.name}.each_with_index do |song, i|
    #   puts "#{i+1}. #{song.name}"
    # end
    Song.all.sort_by{|song| song.name}.each_with_index do |song, i|
      puts "#{i+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artists
    Artist.all.sort_by{|artist| artist.name}.each_with_index do |artist, i|
      puts "#{i+1}. #{artist.name}"
    end
  end

  def list_genres
    Genre.all.sort_by{|genre| genre.name}.each_with_index do |genre, i|
      puts "#{i+1}. #{genre.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    artist_name = gets.strip
    if Artist.find_by_name(artist_name)
      Artist.find_by_name(artist_name).songs.sort_by{|song| song.name}.each_with_index do |song, i|
        puts "#{i+1}. #{song.name} - #{song.genre.name}"
      end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    genre_name = gets.strip
    if Genre.find_by_name(genre_name)
      Genre.find_by_name(genre_name).songs.sort_by{|song| song.name}.each_with_index do |song, i|
        puts "#{i+1}. #{song.artist.name} - #{song.name}"
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    answer1 = gets.to_i
    if answer1 <= Song.all.length && answer1>0
      play = Song.all.sort_by{|song| song.name}[answer1-1]
      puts "Playing #{play.name} by #{play.artist.name}"
    end
  end


end
