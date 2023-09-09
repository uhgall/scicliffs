require 'arx'

def fetch_arxiv_url(id)
  paper = Arx(id)
  paper.pdf_url
end



