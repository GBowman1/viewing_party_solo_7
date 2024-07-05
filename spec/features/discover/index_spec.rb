require 'rails_helper'

RSpec.describe 'Discover Index Page', type: :feature do
  before(:each) do
    @user = User.create!(name: 'John Doe', email: 'johndoe@example.com')
    @top_rated_response = File.read('spec/fixtures/top_rated_fixture.json')
    @search_response = File.read('spec/fixtures/search_fixture.json')

    stub_request(:get, "https://api.themoviedb.org/3/discover/movie?api_key=#{Rails.application.credentials.tmdb[:key]}&include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc").
      to_return(status: 200, body: @top_rated_response, headers: {})

    stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=#{Rails.application.credentials.tmdb[:key]}&query=The%20Godfather&language=en-US&page=1").
      to_return(status: 200, body: @search_response, headers: {})
  end

  it 'shows a button to discover top-rated movies' do
    visit user_discover_index_path(@user)

    expect(page).to have_button('Top Rated Movies')
  end

  it 'shows a text field to search for movies by title and a search button' do
    visit user_discover_index_path(@user)

    expect(page).to have_field('movie')
    expect(page).to have_button('Search')
  end

  it 'redirects to movies results page when clicking the Top Rated Movies button' do
    visit user_discover_index_path(@user)
    click_button 'Top Rated Movies'

    expect(current_path).to eq(user_movies_path(@user))
    within '#movie_1' do
      expect(page).to have_link("Furiosa: A Mad Max Saga")
      expect(page).to have_content("7.715")
    end
  end

  it 'redirects to movies results page when searching for a movie title' do
    visit user_discover_index_path(@user)
    fill_in 'movie', with: 'The Godfather'
    click_button 'Search'

    expect(current_path).to eq(user_movies_path(@user))
    within '#movie_1' do
      expect(page).to have_link("The Godfather")
      expect(page).to have_content("8.7")
    end
  end
end