require 'acceptance/acceptance_helper'

feature 'Replay list with permission' do
  background do
    admin = Fabricate(:admin)
    awesome_replay = Fabricate(:replay, :title => "My Awesome Replay")
    other_replay = Fabricate(:replay, :title => "Another Replay")
    Fabricate(:comment, :text => "Awesome comment", :replay => awesome_replay)
    Fabricate(:comment, :text => "Another comment", :replay => other_replay)
  
    login_as(admin)
    visit '/'
    click_link 'Replays'
    click_link 'My Awesome Replay'
  end

  scenario 'show list of comments' do
    page.should have_content("Awesome comment")
    page.should_not have_content("Another comment")
  end  

  scenario 'add a new comment' do
    fill_in 'comment_text', :with => 'This is my new comment'
    click_button 'Add Comment'

    page.should have_css(".comment", :text => 'This is my new comment')
    page.should have_content("Your comment was added successfully")
  end
end