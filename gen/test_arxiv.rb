require_relative 'utils.rb'
require_relative 'generator.rb'

pdf_file_path = fetch_arxiv_paper('2307.12008')
puts pdf_file_path

puts generate_article(pdf_file_path)
