require 'sinatra'
require_relative 'gen/utils'  
require_relative 'gen/generator'  

get '/:id' do
  arxiv_id = params[:id]
  puts arxiv_id

  pdf_file_path = fetch_arxiv_paper(arxiv_id)
  puts pdf_file_path

  result = generate_article(pdf_file_path) 

  # TODO: add html header and tags

  # Render the result (assuming it's a string). If it's not, convert it accordingly.
  result
end
