require 'rails_helper'

RSpec.describe MovieService do
    before(:each) do
        @top_rated_response = File.read('spec/fixtures/top_rated_fixture.json')
        @search_response = File.read('spec/fixtures/search_fixture.json')

        stub_request(:get, "https://api.themoviedb.org/3/discover/movie?api_key=#{Rails.application.credentials.tmdb[:key]}&include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc").
        to_return(status: 200, body: @top_rated_response, headers: {})

        stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=#{Rails.application.credentials.tmdb[:key]}&query=The%20Godfather&language=en-US&page=1").
        to_return(status: 200, body: @search_response, headers: {})
    end

    describe '.top_rated_movies' do
        it 'returns top rated movies data with 20 items' do
        response = MovieService.top_rated_movies

        expect(response).to be_a(Hash)
        expect(response[:results]).to be_an(Array)
        expect(response[:results].first[:title]).to eq('Furiosa: A Mad Max Saga')
        expect(response[:results].first[:vote_average]).to eq(7.715)
        expect(response[:results].count).to eq(20)
        end
    end

    describe '.search_for_movie' do
        it 'returns search results for a movie with 20 items' do
        response = MovieService.search_for_movie('The Godfather')

        expect(response).to be_a(Hash)
        expect(response[:results]).to be_an(Array)
        expect(response[:results].first[:title]).to eq('The Godfather')
        expect(response[:results].first[:vote_average]).to eq(8.7)
        expect(response[:results].count).to eq(20)
        end
    end
end