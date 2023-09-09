require_relative 'utils.rb'
require_relative 'generator.rb'

# add you code for trying it out here


pdf_name = "2305.14992.pdf"
#pdf_name = "0601108.pdf" # that one weirdly doesn't work, not sure why, article is empty but completion looks right

pdf_file_path = File.join('input',pdf_name)

puts generate_article(pdf_file_path)
