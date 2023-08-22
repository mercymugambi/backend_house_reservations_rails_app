require 'test_helper'

class CsrfTokensControllerTest < ActionDispatch::IntegrationTest
  test 'should get show' do
    get csrf_tokens_show_url
    assert_response :success
  end
end
