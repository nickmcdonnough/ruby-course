require_relative '../spec_helper.rb'

describe Songify::Repos::Artists do
  let(:artist1) { Songify::Artist.new('Ida Engberg') }
  let(:artist2) { Songify::Artist.new('') }

  it 'can save a artist' do
    expect(artist1.id).to be_nil
    Songify.artists.save(artist1)
    expect(artist1.id).to_not be_nil
  end

  it 'can retrieve a artist by it\'s id' do
    Songify.artists.save(artist1)
    result = Songify.artists.find(artist1.id)
    expect(result).to be_a(Songify::Artist)
    expect(result.id).to eq(artist1.id)
  end

  it 'can get all artists' do
    Songify.artists.save(artist1)
    Songify.artists.save(artist2)

    artist_list = Songify.artists.all
    expect(artist_list.size).to eq(2)
  end

  it 'can delete a artist' do
    Songify.artists.save(artist1)
    Songify.artists.save(artist2)

    artist_list = Songify.artists.all
    expect(artist_list.size).to eq(2)

    Songify.artists.delete(artist2.id)
    artist_list = Songify.artists.all
    expect(artist_list.size).to eq(1)
    expect(artist_list.first.name).to eq('Ida Engberg')
  end
end
