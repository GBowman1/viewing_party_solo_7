require 'rails_helper'

RSpec.describe MovieFacade do
    before(:each) do
        @top_rated_response = File.read('spec/fixtures/top_rated_fixture.json')
        @search_response = File.read('spec/fixtures/search_fixture.json')
        @movie_details_response = File.read('spec/fixtures/show_fixture.json')
        @movie_reviews_response = File.read('spec/fixtures/reviews_fixture.json')
        @movie_cast_response = File.read('spec/fixtures/cast_fixture.json')

        stub_request(:get, "https://api.themoviedb.org/3/discover/movie?api_key=#{Rails.application.credentials.tmdb[:key]}&include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc").
        to_return(status: 200, body: @top_rated_response, headers: {})

        stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=#{Rails.application.credentials.tmdb[:key]}&query=The%20Godfather&language=en-US&page=1").
        to_return(status: 200, body: @search_response, headers: {})

        stub_request(:get, "https://api.themoviedb.org/3/movie/786892?api_key=#{Rails.application.credentials.tmdb[:key]}").
        to_return(status: 200, body: @movie_details_response, headers: {})

        stub_request(:get, "https://api.themoviedb.org/3/movie/786892/reviews?api_key=#{Rails.application.credentials.tmdb[:key]}&page=1").
        to_return(status: 200, body: @movie_reviews_response, headers: {})

        stub_request(:get, "https://api.themoviedb.org/3/movie/786892/credits?api_key=#{Rails.application.credentials.tmdb[:key]}").
        to_return(status: 200, body: @movie_cast_response, headers: {})
    end

    it 'can get top rated movies' do
        facade = MovieFacade.new
        movies = facade.get_top_rated_movies

        expect(movies.count).to eq(20)
        expect(movies.first).to be_a(Movie)
    end

    it 'can search for movies by title' do
        facade = MovieFacade.new
        movies = facade.search_for_movie('The Godfather')

        expect(movies.count).to eq(1)
        expect(movies.first.title).to eq('The Godfather')
    end

    it 'can get movie details' do
        facade = MovieFacade.new
        movie = facade.get_movie_details(786892)

        expect(movie).to be_a(Movie)
        expect(movie.title).to eq('Furiosa: A Mad Max Saga')
        expect(movie.cast.count).to eq(10)
        expect(movie.reviews.count).to eq(7)
    end
end