require_relative '../spec_helper.rb'

describe Songify::Repos::Genres do
  it 'can save a genre' do
    genre = Songify::Genre.new('Techno')
    expect(genre.id).to be_nil
    Songify.genres.save(genre)
    expect(genre.id).to_not be_nil
  end

  it 'can retrieve a genre by it\'s id' do
    genre = Songify::Genre.new('Techno')
    Songify.genres.save(genre)
    result = Songify.genres.find(genre.id)
    expect(result).to be_a(Songify::Genre)
    expect(result.id).to eq(genre.id)
  end

  it 'can get all genres' do
    genre1 = Songify::Genre.new('Techno')
    genre2 = Songify::Genre.new('Techno House')
    Songify.genres.save(genre1)
    Songify.genres.save(genre2)

    genre_list = Songify.genres.all
    expect(genre_list.size).to eq(2)
  end

  it 'can delete a genre' do
    genre1 = Songify::Genre.new('Techno')
    genre2 = Songify::Genre.new('Techno House')
    Songify.genres.save(genre1)
    Songify.genres.save(genre2)

    genre_list = Songify.genres.all
    expect(genre_list.size).to eq(2)

    Songify.genres.delete(genre2.id)
    genre_list = Songify.genres.all
    expect(genre_list.size).to eq(1)
    expect(genre_list.first.name).to eq('Techno')
  end
end
