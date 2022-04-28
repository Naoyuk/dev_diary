# frozen_string_literal

module PostsHelper
  require 'rouge'
  require 'rouge/plugins/redcarpet'

  class RougeHTML < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet
  end

  def markdown(text)
    render_options = {
      no_links: false,
      hard_wrap: true,
      link_attributes: { target: '_blank' }
    }
    extensions = {
      hard_wrap: true,
      autolink: true,
      no_intra_emphasis: true,
      tables: true,
      fenced_code_blocks: true,
      disable_indented_code_blocks: true,
      strikethrough: true,
      lax_spacing: true,
      spece_after_headers: true,
      quote: true,
      footnotes: true,
      highlight: true,
      underline: true,
      with_toc_data: true,
      prettify: true
    }

    renderer = RougeHTML.new(render_options)
    Redcarpet::Markdown.new(renderer, extensions).render(text).html_safe
  end

  def is_published?(post)
    post.published
  end
end
