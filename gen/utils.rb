require 'arx'
require 'net/http'
require 'uri'

def fetch_arxiv_paper(id)
  paper = Arx(id)
  # Parse the URL
  uri = URI.parse(paper.pdf_url)

  # Define the path to save the file
  file_path = File.join('..', 'input', "#{id}.pdf")


  # Use Net::HTTP to download the file
  Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
    request = Net::HTTP::Get.new(uri)

    http.request(request) do |response|
      # Open a file for writing
      File.open(file_path, 'wb') do |file|
        # Stream the file to disk
        response.read_body do |chunk|
          file.write(chunk)
        end
      end
    end
  end

end



