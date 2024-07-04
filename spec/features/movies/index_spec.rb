require 'rails_helper'

RSpec.describe 'Movies Index Page' do
    feature 'visitor can view movies results' do
        before :each do
            @user = User.create!(name: 'Mike Tyson', email: 'miketyson@aol.com')
            @json_response = JSON.parse(File.read('spec/fixtures/top_rated_fixture.json'))
            stub_request(:get, "https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc").with(
                headers: {
                    'Accept'=>'*/*',
                    'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                    'User-Agent'=>'Faraday v2.9.2',
                    'X-Api-Key'=>'aa8f476e09c282147d59ae9a584801f6'
                    }).to_return(status: 200, body: @json_response.to_json, headers: {})
                    
            @search = JSON.parse(File.read('spec/fixtures/search_fixture.json'))
            stub_request(:get, "https://api.themoviedb.org/3/search/movie?query=The%20Godfather").with(
                headers: {
                'Accept'=>'*/*',
                'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                'User-Agent'=>'Faraday v2.9.2',
                'X-Api-Key'=>'aa8f476e09c282147d59ae9a584801f6'
                }).
                to_return(status: 200, body: @search.to_json, headers: {})
        end

        it 'visitor can see top rated movies' do
            visit user_discover_index_path(@user)
            within '#page_actions' do
                click_button 'Top Rated Movies'
            end
            expect(current_path).to eq(user_movies_path(@user))

            expect(@json_response['results'].count).to eq(20)

            within '#movie_1' do
                expect(page).to have_link("Furiosa: A Mad Max Saga")
                expect(page).to have_content("7.715")
            end
        end
        
        scenario 'Visitor can return to discover page' do
        end
    end
end