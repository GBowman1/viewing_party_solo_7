require 'rails_helper'

RSpec.describe MovieFacade do
    before(:each) do
        @top_rated_response = File.read('spec/fixtures/top_rated_fixture.json')
        @search_response = File.read('spec/fixtures/search_fixture.json')

        stub_request(:get, "https://api.themoviedb.org/3/discover/movie?api_key=#{Rails.application.credentials.tmdb[:key]}&include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc").
        to_return(status: 200, body: @top_rated_response, headers: {})

        stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=#{Rails.application.credentials.tmdb[:key]}&query=The%20Godfather&language=en-US&page=1").
        to_return(status: 200, body: @search_response, headers: {})
    end

    it 'can get top rated movies limit response 20' do
        movies = MovieFacade.new.get_top_rated_movies

        expect(movies).to be_an(Array)
        expect(movies.first).to be_a(Movie)
        expect(movies.first.title).to eq('Furiosa: A Mad Max Saga')
        expect(movies.first.vote_average).to eq(7.715)
        expect(movies.count).to eq(20)
    end

    it 'can search for movies by title limit response 20' do
        movies = MovieFacade.new.search_for_movie('The Godfather')

        expect(movies).to be_an(Array)
        expect(movies.first).to be_a(Movie)
        expect(movies.first.title).to eq('The Godfather')
        expect(movies.first.vote_average).to eq(8.7)
        expect(movies.count).to eq(20)
    end
end