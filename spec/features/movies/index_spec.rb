require 'rails_helper'

RSpec.describe 'Movies Index Page' do
    feature 'visitor can view movies results' do
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
        scenario 'Visitor can see titles as a link to movie details page and vote average' do

            visit user_discover_index_path(@user)
            within '#page_actions' do
                click_button 'Top Rated Movies'
            end
            expect(current_path).to eq(user_movies_path(@user))

            expect(@movies.count).to eq 20
            @movies.each do |movie|
                within "#movie_#{movie[:id]}" do
                    expect(page).to have_link(movie[:title])
                    expect(page).to have_content(movie[:vote_average])
                end
            end
            # button test

        end
        scenario 'Visitor can return to discover page' do
        end
    end
end