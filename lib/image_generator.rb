require 'fileutils'
require_relative 'openai_client'
require_relative 'prompts'

class ImageGenerator
  def initialize(client = OpenAIClient.new)
    @client = client
  end

  def generate_images(concept, prompt, num_images = 1, folder = 'result', name_prefix = nil)
    FileUtils.mkdir_p(folder)
    response = @client.generate_images(prompt, num_images)

    response['data'].each_with_index do |image_data, index|
      image_url = image_data['url']
      puts "  Image generated: #{image_url}"

      # Download and save each image
      image_content = @client.download_image(image_url)

      # Define the image name
      file_name = name_prefix ? "#{name_prefix}_#{index + 1}.png" : "#{concept.gsub(' ', '_')}_#{index + 1}_#{Time.now.to_i}.png"

      # Save the image to the specified directory
      image_file = "#{folder}/#{file_name}"
      File.write(image_file, image_content)
      puts "Image #{index + 1} saved to #{image_file}"
    end
  end

  def generate_samples(sample_prompt)
    FileUtils.mkdir_p('samples')

    Prompts::LIST.each do |keyword, prompt|
      puts "Generating 3 samples for keyword: #{keyword}"
      generate_images(sample_prompt, prompt, 3, 'samples', keyword)
    end
  end
end
