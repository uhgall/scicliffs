require 'pdf-reader'
require 'glim_ai'

# for now, this just returns one string with everything in it 
# later we will want to be more structured
def generate_article(pdf_file_path)

    forced_default_llm = ENV.fetch('DEFAULT_LLM_NAME')

    reader = PDF::Reader.new(pdf_file_path)

    full_text_from_paper = ""
    reader.pages.each do |page|
        full_text_from_paper += page.text
    end

    glim = GlimContext.new

    # do these in parallel
    req_article = glim.request_from_template('article', full_text_from_paper:)
    req_article.llm_name = forced_default_llm if forced_default_llm
    req_errata = glim.request_from_template('errata', full_text_from_paper:)
    req_errata.llm_name = forced_default_llm if forced_default_llm

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

    output_text += "\n# Image prompts (TODO):\n"
    for image_prompt in image_prompts
        output_text += "\n\n* #{image_prompt}"
    end
    
    errata = req_errata.response.completion
    output_text += "\n\n# Errata:\n\n #{errata}\n"

    cost = [req_article, req_headline, req_teaser, req_images, req_errata].map { |x| x.response.total_cost }.sum
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
