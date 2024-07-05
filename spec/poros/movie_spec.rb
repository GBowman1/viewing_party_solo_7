require 'rails_helper'

RSpec.describe Movie do
    before :each do
        @movie_data = {
            title: 'Furiosa: A Mad Max Saga',
            vote_average: 7.715,
            id: 786892,
            summary: 'As the world fell, young Furiosa is snatched from the Green Place of Many Mothers and falls into the hands of a great Biker Horde led by the Warlord Dementus. Sweeping through the Wasteland they come across the Citadel presided over by The Immortan Joe. While the two Tyrants war for dominance, Furiosa must survive many trials as she puts together the means to find her way home.',
            genres: [{name: 'Action'}, {name: 'Adventure'}, {name: 'Science Fiction'}],
            runtime: 149
        }
    end
    it 'it turns api data into attributes' do
        movie = Movie.new(@movie_data)

        expect(movie).to be_a(Movie)
        expect(movie.title).to eq('Furiosa: A Mad Max Saga')
        expect(movie.vote_average).to eq(7.715)
        expect(movie.id).to eq(786892)
    end

    xit '#genres_arr' do
        @movie = Movie.new(@movie_data)

        expect(@movie.genres_arr(@movie_data)).to eq(["Action", "Adventure", "Science Fiction"])
    end

    it '#runtime_conversion' do
        @movie = Movie.new(@movie_data)
        expect(@movie.runtime_conversion(149)).to eq("2 hr 29 min")
    end
end