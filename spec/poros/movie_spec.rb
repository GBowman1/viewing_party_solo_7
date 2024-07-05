require 'rails_helper'

RSpec.describe Movie do
    it 'it turns api data into attributes' do
        movie_data = {
        title: 'Furiosa: A Mad Max Saga',
        vote_average: 7.715,
        id: 786892
        }

        movie = Movie.new(movie_data)

        expect(movie).to be_a(Movie)
        expect(movie.title).to eq('Furiosa: A Mad Max Saga')
        expect(movie.vote_average).to eq(7.715)
        expect(movie.id).to eq(786892)
    end
end