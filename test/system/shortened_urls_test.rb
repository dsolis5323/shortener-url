require 'application_system_test_case'

class ShortenedUrlsTest < ApplicationSystemTestCase
  setup do
    @shortened_url = shortened_urls(:one)
  end

  test 'visiting the index' do
    visit shortened_urls_url
    assert_selector 'h1', text: 'Shortened urls'
  end

  test 'should create shortened url' do
    visit shortened_urls_url
    click_on 'New shortened url'

    fill_in 'Original url', with: @shortened_url.original_url
    fill_in 'Redirects', with: @shortened_url.redirects
    fill_in 'Short url', with: @shortened_url.short_url
    fill_in 'Title', with: @shortened_url.title
    click_on 'Create Shortened url'

    assert_text 'Shortened url was successfully created'
    click_on 'Back'
  end

  test 'should update Shortened url' do
    visit shortened_url_url(@shortened_url)
    click_on 'Edit this shortened url', match: :first

    fill_in 'Original url', with: @shortened_url.original_url
    fill_in 'Redirects', with: @shortened_url.redirects
    fill_in 'Short url', with: @shortened_url.short_url
    fill_in 'Title', with: @shortened_url.title
    click_on 'Update Shortened url'

    assert_text 'Shortened url was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Shortened url' do
    visit shortened_url_url(@shortened_url)
    click_on 'Destroy this shortened url', match: :first

    assert_text 'Shortened url was successfully destroyed'
  end
end
