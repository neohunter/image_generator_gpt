require 'openai'
require 'net/http'
require 'uri'

class OpenAIClient
  def initialize(api_key = ENV['OPENAI_API_KEY'])
    @client = OpenAI::Client.new(access_token: api_key)
  end

  def generate_images(prompt, num_images)
    @client.images.generate(parameters: {
      model: "dall-e-3",
      quality: "standard", 
      prompt: prompt,
      n: num_images,
      size: "1024x1024"
    })
  end

  def download_image(image_url)
    uri = URI.parse(image_url)
    Net::HTTP.get(uri)
  end
end
