require_relative 'generator.rb'

#pdf_name = "2305.14992.pdf"

pdf_name = "2307.12008.pdf"

#pdf_name = "0601108.pdf" # that one weirdly doesn't work, not sure why, article is empty but completion looks right

pdf_file_path = File.join('input',pdf_name)

output_text = generate_article(pdf_file_path)

outfilename = pdf_name.gsub('.pdf', '.md')
f = File.open(File.join('output',outfilename), 'w')
f.write(output_text)
f.close
