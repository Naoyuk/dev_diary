# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PostMarkdowns', type: :system do
  before do
    driven_by(:rack_test)
  end

  describe 'render contents' do
    it 'return html safe rendered markdown' do
      text = "# test title\n\n*italic*\n\n**bold**\n\n[example](www.example.com)"
      markdown_rendered_text = markdown(text) 

      expect(markdown_rendered_text).to eq(
        "<h1>test title</h1>\n\n<p><em>italic</em></p>\n\n<p><strong>bold</strong></p>\n\n<p><a href=\"www.example.com\" target=\"_blank\">example</a></p>\n"
      )
    end
  end
end
