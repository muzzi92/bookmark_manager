require_relative '../../app.rb'
require 'spec_helper'
require 'pg'


feature BookmarkManager do

  feature 'Viewing bookmarks' do
    scenario 'A user can see bookmarks' do
      visit_and_add_bookmark
      expect(page).to have_content("Makers")
    end
  end

  feature 'Adding bookmarks' do
    scenario 'User should receive confirmation' do
      visit'/'
      click_button 'Add bookmark'
      fill_in 'Name', with: 'Yahoo'
      fill_in 'Url', with: 'http://yahoo.com'
      click_button 'Submit'
      expect(page).to have_content "Yahoo"
    end

    scenario 'Should take you to error page' do
      visit'/'
      click_button 'Add bookmark'
      fill_in 'Name', with: '12345'
      fill_in 'Url', with: '12345'
      click_button 'Submit'
      expect(page).to have_content('INVALID URL')
    end
  end

  feature 'Deleting bookmarks' do
    scenario 'Selected bookmark is removed' do
      visit_and_add_bookmark
      click_button 'Delete bookmark'
      fill_in 'Name', with: 'Makers'
      click_button 'Delete'
      expect(page).not_to have_content 'Makers'
    end
  end

end
