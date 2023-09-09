require 'sinatra'
require 'redcarpet'

require_relative 'gen/load_papers'  
require_relative 'gen/generator'  

def markdown_to_html(markdown_content, original_work_uri)
    renderer = Redcarpet::Render::HTML.new
    markdown = Redcarpet::Markdown.new(renderer)
    html_content = markdown.render(markdown_content)
  
    # Append a link to the original work URI before the closing body tag
    link_html = "<p><a href='#{original_work_uri}'>Original Work</a></p>"
  
    # Check if the closing body tag exists
    if html_content.include?("</body>")
      # Insert the link before the closing body tag
      insert_position = html_content.index("</body>")
      html_content.insert(insert_position, link_html)
    else
      # If there's no closing body tag, just append the link
      html_content += link_html
    end
    
    html_content
  end
  


get '/:id' do
  arxiv_id = params[:id]
  puts arxiv_id

  pdf_file_path = fetch_arxiv_paper(arxiv_id)
  puts pdf_file_path

  markdown_content = generate_article(pdf_file_path)
  puts markdown_content

  html_content = markdown_to_html(markdown_content, "https://arxiv.org/abs/" + arxiv_id)
  html_content
end
