require 'arx'
require 'rest-client'
require 'uri'

def fetch_arxiv_paper(id)
  paper = Arx(id)

  # Define the path to save the file
  file_path = File.join('input', "#{id}.pdf")
  
  # Print absolute path for debugging
  absolute_path = File.expand_path(file_path)
  puts "Attempting to write to: #{absolute_path}"

  # Fetch the PDF using rest-client
  response = RestClient.get(paper.pdf_url, {
    user_agent: 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537'
  })

  # Write the response body to a file
  File.open(file_path, 'wb') { |file| file.write(response.body) }

  # Return the file_path
  file_path
end
