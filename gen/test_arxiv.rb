require_relative 'utils.rb'
require_relative 'generator.rb'

id = '2307.12008'

puts get_article_for_arxiv_id(id)

# pdf_file_path = fetch_arxiv_paper('2307.12008')
# puts pdf_file_path

# puts generate_article(pdf_file_path)
