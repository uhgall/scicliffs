require 'rest-client'
require 'uri'

def fetch_arxiv_paper(id)
  # Define the path to save the file
  file_path = File.join('input', "#{id}.pdf")
  
  # Print absolute path for debugging
  absolute_path = File.expand_path(file_path)
  puts "Attempting to write to: #{absolute_path}"

  # Check if the file already exists
  if File.exist?(file_path)
    puts "File already exists at: #{absolute_path}"
    return file_path
  end

  # Fetch the PDF using rest-client
  response = RestClient.get("https://arxiv.org/pdf/" + arxiv_id, {
    user_agent: 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537'
  })

  # Write the response body to a file
  File.open(file_path, 'wb') { |file| file.write(response.body) }

  # Return the file_path
  file_path
end

def get_article_for_arxiv_id(id)
  # if we already have a .md file, use it
  output_dir = File.join('output', 'arxiv')
  md_file_path = File.join(output_dir, "#{id}.md")
  if File.exist?(md_file_path)
    puts "Returning cached generated article: #{md_file_path}"
    return File.read(md_file_path)
  end
  pdf_file_path = fetch_arxiv_paper(id)
  puts "Generating article for #{pdf_file_path} and saving to #{md_file_path}"
  # save this to md_file_path
  output_text = generate_article(pdf_file_path)
  f = File.open(md_file_path, 'w')
  f.write(output_text)
  f.close
  return output_text
end
