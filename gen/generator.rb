require 'pdf-reader'
require 'glim_ai'
# require_relative 'utils'


# for now, this just returns one string with everything in it 
# later we will want to be more structured
def generate_article(pdf_file_path)

    forced_default_llm = ENV.fetch('DEFAULT_LLM_NAME')

    reader = PDF::Reader.new(pdf_file_path)

    full_text_from_paper = ""
    reader.pages.each do |page|
        full_text_from_paper += page.text
    end

    # # use Arx gem to fetch pdf url for a paper by its arxiv.org id
    # arxiv_url = fetch_arxiv_url('2307.12008')
    # puts arxiv_url

    glim = GlimContext.new

    # do these in parallel
    req_article = glim.request_from_template('article', full_text_from_paper:)
    req_article.llm_name = forced_default_llm if forced_default_llm
    # req_errata = glim.request_from_template('errata', full_text_from_paper:)
    # req_errata.llm_name = forced_default_llm if forced_default_llm

    article_completion = req_article.response.completion
    _, files = extract_and_save_files(article_completion)
    article = files["article.md"]

    raise "No article found in completion:\n#{article_completion}" if article.nil? || article.empty?

    # do these in parallel
    req_headline = glim.request_from_template('headline', article:)
    req_headline.llm_name = forced_default_llm if forced_default_llm

    req_teaser = glim.request_from_template('teaser', article:)
    req_teaser.llm_name = forced_default_llm if forced_default_llm

    req_images = glim.request_from_template('images', article:)
    req_images.llm_name = forced_default_llm if forced_default_llm

    headline = req_headline.response.completion
    teaser = req_teaser.response.completion

    _, files = extract_and_save_files(req_images.response.completion)
    image_prompts = files["prompts.txt"].split("\n")

    output_text = "# #{headline} \n\n #{teaser}\n\n #{article}" 

    output_text += "\n\n-----\nImage prompts (TODO):\n" + image_prompts.join("\n")

    # errata = req_errata.response.completion
    # output_text += "\n\n-----\nErrata:\n\n #{errata}\n"


    cost = [req_article, req_headline, req_teaser, req_images].map { |x| x.response.total_cost }.sum
    puts "Total Cost: $ #{cost}"

    return output_text
    
    # Or we could do something more structured, like:
    #
    # Headline
    # Why should I care?
    # What is the main contribution?
    # Summary
    # Introduction
    # How did they do it
    # What were their conclusions
end


# pdf_name = "2305.14992.pdf"
# #pdf_name = "0601108.pdf" # that one weirdly doesn't work, not sure why, article is empty but completion looks right

# pdf_file_path = File.join('input',pdf_name)

# puts generate_article(pdf_file_path)