require 'arx'
require 'net/http'
require 'uri'
require 'arx'
require 'net/http'
require 'uri'

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
    max_redirects = 100
    redirect_count = 0

    response = nil
    while redirect_count < max_redirects
      request = Net::HTTP::Get.new(uri)
      # Add a User-Agent header
      request['User-Agent'] = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537'
      response = http.request(request)

      puts redirect_count, response

      break unless response.is_a?(Net::HTTPRedirection)

      uri = URI.parse(response['location'])
      redirect_count += 1
    end

    if response.is_a?(Net::HTTPRedirection)
      raise "Too many redirects" 
    end
    
    # Open a file for writing
    File.open(file_path, 'wb') do |file|
      # Stream the file to disk
      response.read_body do |chunk|
        file.write(chunk)
      end
    end
  end

  # Return the file_path
  file_path
end
