require 'spec_helper'

describe 'Tweets' do

  it 'lists latest 50 tweets' do
    visit root_path
    page.should have_content('Latest Geo Tweets')
  end

  it 'lists latest tweets based on geo location specified by the user' do
    visit root_path

    fill_in 'geolong', with: '-77.423456'
    fill_in 'geolat', with: '42.989259'

    click_button 'go-button'

    page.should have_content('Latest Geo Tweets')
  end

end