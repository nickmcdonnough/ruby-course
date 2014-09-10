require_relative '../spec_helper.rb'

describe Songify::Repositories::Songs do
  after do
    Songify.songs_repo.drop_table
  end

  it 'can save a song' do
    song = Songify::Song.new('fake_title', 'fake_artist', 'fake_album')
    expect(song.id).to be_nil
    Songify.songs_repo.save_song(song)
    expect(song.id).to_not be_nil
  end

  it 'can retrieve a song by it\'s id' do
    song = Songify::Song.new('fake_title', 'fake_artist', 'fake_album')
    Songify.songs_repo.save_song(song)
    result = Songify.songs_repo.get_a_song(song.id)
    expect(result).to be_a(Songify::Song)
    expect(result.id).to eq(song.id)
  end

  it 'can get all songs' do
    song1 = Songify::Song.new('fake_title', 'fake_artist', 'fake_album')
    song2 = Songify::Song.new('fake_title2', 'fake_artist2', 'fake_album2')
    Songify.songs_repo.save_song(song1)
    Songify.songs_repo.save_song(song2)

    song_list = Songify.songs_repo.get_all_songs
    expect(song_list.size).to eq(2)
  end

  it 'can delete a song' do
    song1 = Songify::Song.new('fake_title', 'fake_artist', 'fake_album')
    song2 = Songify::Song.new('fake_title2', 'fake_artist2', 'fake_album2')
    Songify.songs_repo.save_song(song1)
    Songify.songs_repo.save_song(song2)

    song_list = Songify.songs_repo.get_all_songs
    expect(song_list.size).to eq(2)

    Songify.songs_repo.delete_a_song(song2.id)
    song_list = Songify.songs_repo.get_all_songs
    expect(song_list.size).to eq(1)
    expect(song_list.first.title).to eq('fake_title')
  end

  it 'can save multiple objects at once' do
    song1 = Songify::Song.new('fake_title', 'fake_artist', 'fake_album')
    song2 = Songify::Song.new('fake_title2', 'fake_artist2', 'fake_album2')
    Songify.songs_repo.save_song(song1, song2)

    song_list = Songify.songs_repo.get_all_songs
    expect(song_list.size).to eq(2)
  end
end
