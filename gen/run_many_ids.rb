require_relative 'load_papers.rb'
require_relative 'generator.rb'

ids = ['2307.12008', '2302.13971v1' , '2303.08774v3','2305.14992','2309.03793','2309.03874','2309.03440']

for id in ids
    puts get_article_for_arxiv_id(id)
end
# pdf_file_path = fetch_arxiv_paper('2307.12008')
# puts pdf_file_path

# puts generate_article(pdf_file_path)
