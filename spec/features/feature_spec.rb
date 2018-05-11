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

  feature 'Updating bookmarks' do
    scenario 'Selected bookmark is updated' do
      visit_and_add_bookmark
      click_button 'Update bookmark'
      fill_in 'Name', with: 'Makers'
      fill_in 'New_name', with: 'Coding Bootcamp'
      click_button 'Update'
      expect(page).to have_content 'Coding Bootcamp'
      expect(page).not_to have_content 'Makers'
    end
  end

  # feature 'Commenting on bookmarks' do
  #   scenario 'Comment is added to comments table' do
  #     visit_and_add_bookmark
  #     click_button 'Comment'
  #     fill_in 'comment', with: 'p everywhere'
  #     click_button 'Submit'
  #     expect(page).to have_content 'p everywhere'
  #
  #     end
  #   end



end
