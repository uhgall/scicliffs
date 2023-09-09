require 'net/http'
require 'json'

class MediumUploader
  BASE_URL = 'https://api.medium.com/v1'.freeze

  def initialize(integration_token)
    @token = integration_token
  end

  def upload_post(title, content, tags = [])

    user = get_user_id

    uri = URI("#{BASE_URL}/v1/users/#{user}foop/posts")

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri.path,
                                  {
                                    'Authorization' => "Bearer #{@token}",
                                    'Content-Type' => 'application/json',
                                    'Accept' => 'application/json'
                                  })

    request.body = {
      title: title,
      contentFormat: 'markdown',
      content: content,
      tags: tags,
      publishStatus: 'draft'
    }.to_json

    response = http.request(request)

    puts response.body
#    JSON.parse(response.body)
  end

  def get_user_id
    uri = URI("#{BASE_URL}/me")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
  
    request = Net::HTTP::Get.new(uri.path,
                                 {
                                   'Authorization' => "Bearer #{@token}",
                                   'Content-Type' => 'application/json',
                                   'Accept' => 'application/json'
                                 })
  
    response = http.request(request)
    JSON.parse(response.body)["data"]["id"]
  end
  
end

# Usage example
uploader = MediumUploader.new('2157168885f99f992e763822d0138e09154603c9fbefa61648a9e9454c68ae47e')
response = uploader.upload_post('Test Post', 'This is a test post content.', ['Ruby', 'API'])
puts response



