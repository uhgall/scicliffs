require_relative 'generator.rb'

#pdf_name = "2305.14992.pdf"

ids = ['2307.12008']

for id in ids
    pdf_name = "#{id}.pdf"
    pdf_file_path = File.join('input',pdf_name)
    output_text = generate_article(pdf_file_path)
    outfilename = pdf_name.gsub('.pdf', '.md')
    puts "Writing to #{outfilename}"
    f = File.open(File.join('output',outfilename), 'w')
    f.write(output_text)
    f.close
end
