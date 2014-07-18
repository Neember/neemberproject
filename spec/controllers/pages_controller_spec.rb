require 'rails_helper'

describe PagesController do
  describe 'get#help' do
    def do_request
      get :help
    end
    it 'display help page' do
      do_request

      expect(response).to render_template :help
    end
  end
end
