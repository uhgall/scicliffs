require 'arxiv'

def fetch_arxiv_papers(n)
  results = Arxiv.query(search_query: "all:", start: 0, max_results: n)
  results.map(&:id)
end

puts fetch_arxiv_papers(3)
