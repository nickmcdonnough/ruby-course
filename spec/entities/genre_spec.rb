require_relative '../spec_helper.rb'

describe Songify::Genre do
  let(:genre) { Songify::Genre.new('Techno') }

  it 'will initialize with 3 attributes' do
    expect(genre.name).to eq('Techno')
  end
end
