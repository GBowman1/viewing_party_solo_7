require 'rails_helper'

RSpec.describe 'Movies Index Page', type: :feature do
    before(:each) do
        @user = User.create!(name: 'Mike Tyson', email: 'miketyson@aol.com')
        @top_rated_response = File.read('spec/fixtures/top_rated_fixture.json')
        @search_response = File.read('spec/fixtures/search_fixture.json')

        stub_request(:get, "https://api.themoviedb.org/3/discover/movie?api_key=#{Rails.application.credentials.tmdb[:key]}&include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc").
        to_return(status: 200, body: @top_rated_response, headers: {})

        stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=#{Rails.application.credentials.tmdb[:key]}&query=The%20Godfather&language=en-US&page=1").
        to_return(status: 200, body: @search_response, headers: {})
    end

    it 'shows movie details' do
        visit user_movies_path(@user)

        within '#movie_1' do
            expect(page).to have_link("Furiosa: A Mad Max Saga")
            click_link("Furiosa: A Mad Max Saga")
        end
        expect(current_path).to eq(user_movie_path(@user, movie_id: 786892))
    end

    it 'has a button to return to the discover page' do
    end
    
    it 'has a button to create a viewing party' do
    end
end