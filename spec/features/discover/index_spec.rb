require 'rails_helper'

RSpec.describe 'Discover Index Page' do
  feature 'vistior can find movies' do
    before :each do
      @user = User.create!(name: 'Mike Tyson', email: 'miketyson@aol.com')
      json_response = File.read('spec/fixtures/top_rated_fixture.json')
      stub_request(:get, "https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc").with(
          headers: {
              'Accept'=>'*/*',
              'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'User-Agent'=>'Faraday v2.9.2',
              'X-Api-Key'=>'aa8f476e09c282147d59ae9a584801f6'
              }).to_return(status: 200, body: json_response, headers: {})
              
      search = File.read('spec/fixtures/search_fixture.json')
      stub_request(:get, "https://api.themoviedb.org/3/search/movie?query=The%20Godfather").with(
          headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.9.2',
          'X-Api-Key'=>'aa8f476e09c282147d59ae9a584801f6'
          }).
          to_return(status: 200, body: search, headers: {})
    end
    scenario 'a button to discover top rated movies' do
      visit user_discover_index_path(@user)
      within '#page_actions' do
        expect(page).to have_button('Top Rated Movies')

        click_button 'Top Rated Movies'

        expect(current_path).to eq(user_movies_path(@user))
      end
    end

    scenario 'a text field to enter keyword(s) to search by movie title with button' do
      visit user_discover_index_path(@user)
      within '#page_actions' do
        expect(page).to have_field('movie')
        expect(page).to have_button('Search')

        fill_in 'movie', with: 'The Godfather'
        click_button 'Search'

        expect(current_path).to eq(user_movies_path(@user))
      end
    end
    # When I visit the discover movies page ('/users/:id/discover'),
    # and click on either the Discover Top Rated Movies button or fill out the movie title search and click the Search button,
    # I should be taken to the movies results page (`users/:user_id/movies`) where I see: 

    # - Title (As a Link to the Movie Details page (see story #3))
    # - Vote Average of the movie

    # I should also see a button to return to the Discover Page.
  end
end
