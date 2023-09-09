require 'sinatra'
require_relative 'gen/utils'  
require_relative 'gen/generator'  

require 'redcarpet'

def markdown_to_html(markdown_content)
  renderer = Redcarpet::Render::HTML.new
  markdown = Redcarpet::Markdown.new(renderer)
  html_content = markdown.render(markdown_content)
  html_content
end


get '/:id' do
  arxiv_id = params[:id]
  puts arxiv_id

  pdf_file_path = fetch_arxiv_paper(arxiv_id)
  puts pdf_file_path

  markdown_content = generate_article(pdf_file_path)
  puts markdown_content

  html_content = markdown_to_html(markdown_content)
  html_content
end
