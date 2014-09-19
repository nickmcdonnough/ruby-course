require_relative '../spec_helper.rb'

describe Songify::Artist do
  let(:artist) { Songify::Artist.new('Alan Fitzpatrick') }

  it 'will initialize with 3 attributes' do
    expect(artist.name).to eq('Alan Fitzpatrick')
  end
end
