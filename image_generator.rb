require 'net/http'
require 'json'
require 'fileutils'
require 'openai'
require 'uri'


# Ensure your OpenAI API key is set in your environment variables
#   export OPENAI_API_KEY="your-api-key"
OPENAI_API_KEY = ENV['OPENAI_API_KEY']
# Exit if the API key is not set
if OPENAI_API_KEY.nil? || OPENAI_API_KEY.empty?
  puts "Please set the OPENAI_API_KEY environment variable."
  exit
end


client = OpenAI::Client.new(access_token: OPENAI_API_KEY)

# Define the prompts (prompt_id)
PROMPTS = {
  1  => "A vibrant cartoon style depicting an action-packed cityscape, full of dynamic characters, vivid colors, and exaggerated expressions. The style should resemble classic Saturday morning cartoons, with bold lines and a playful tone.",
  2  => "An anime-style scene featuring futuristic technology in a cyberpunk city. Focus on neon lights, rain-soaked streets, and characters with sharp, expressive features. The aesthetic should resemble traditional anime with a modern, high-tech twist.",
  3  => "An ultra-realistic portrait of a character in medieval armor, emphasizing the fine details of the materials, lighting, and facial features. The style should make the character look almost lifelike, as if captured by a high-end camera.",
  4  => "A minimalist line drawing of a serene nature landscape. Focus on simplicity and elegance, with clean, flowing lines and minimal use of color. The style should be calming and abstract, representing a peaceful natural scene.",
  5  => "A surrealist painting with dream-like elements, blending strange, imaginative shapes and vivid colors. The style should resemble the works of early 20th-century surrealist artists, with bizarre compositions and fantastical imagery.",
  6  => "A sleek modern business card design, emphasizing minimalism, clean fonts, and a professional aesthetic. Use soft gradients and a touch of metallic texture.",
  7  => "A flat design of a mobile app interface for an e-commerce platform, with clear call-to-actions, modern icons, and a user-friendly navigation experience.",
  8  => "A vintage-inspired poster promoting a concert, with bold typography, distressed textures, and a color scheme reminiscent of the 1970s.",
  9  => "A watercolor-style illustration of a cozy coffee shop scene, with soft pastel colors and a warm, inviting atmosphere.",
  10 => "A 3D render of a futuristic car design, with sleek curves, glowing lights, and a dynamic stance. The style should feel high-tech and forward-looking.",
  11 => "An isometric vector illustration of a smart city, featuring self-driving cars, green energy sources, and modern architecture, all rendered in clean lines and bright colors.",
  12 => "A stylized infographic representing data on global climate change, using a combination of icons, charts, and a cohesive color palette to make the data visually compelling.",
  13 => "A bold graffiti-style logo for a streetwear brand, using bright colors and abstract shapes to give a sense of urban energy and movement.",
  14 => "A retro-style illustration of a diner from the 1950s, with neon signs, chrome finishes, and cheerful customers enjoying milkshakes and burgers.",
  15 => "A concept art piece showing a fantasy kingdom on floating islands, with detailed castles, waterfalls falling into the sky, and lush greenery.",
  16 => "A hyper-realistic photograph of a luxury watch on a marble surface, with dramatic lighting highlighting its polished metal and intricate details.",
  17 => "A studio photograph of a high-end sports shoe, focusing on its textures, materials, and dynamic shape. Use dramatic lighting for a striking effect.",
  18 => "A lifestyle photograph of a model in a modern, minimalist living room, showcasing the latest fashion trends. Soft natural light floods the scene.",
  19 => "An editorial-style photograph of a gourmet dish plated on a rustic wooden table, with attention to the vibrant colors of the ingredients and the textures of the dish.",
  20 => "A travel photograph of a tropical beach at sunset, with the golden light casting a warm glow over the sand and waves gently rolling in."
}

# Function to generate image (mocked API call)
def generate_images(concept, prompt, num_images = 1)
  client = OpenAI::Client.new(access_token: OPENAI_API_KEY)

  # Mockup for API request (you would replace this with an actual API call)
  puts "Generating image for concept: #{concept}, using prompt: #{prompt}"
  response = client.images.generate(parameters: {
    prompt: "#{concept}. #{prompt}",
    n: num_images,
    size: "1024x1024"
  })

  response['data'].each_with_index do |image_data, index|
    image_url = image_data['url']
    puts "  Image generated: #{image_url}"

    # Download and save each image
    uri = URI.parse(image_url)
    image_content = Net::HTTP.get(uri)

    # Save the image to the result directory
    image_file = "result/#{concept.gsub(' ', '_')}_#{index + 1}_#{Time.now.to_i}.png"
    File.write(image_file, image_content)
    puts "Image #{index + 1} saved to #{image_file}"
  end
end

# Main function to process the arguments
def main
  if ARGV.size != 3
    puts "Usage: ruby image_generator.rb <number_of_images> <prompt_id> <concept>"
    exit
  end

  number_of_images = ARGV[0].to_i
  prompt_id = ARGV[1].to_i
  concept = ARGV[2]

  # Ensure valid prompt_id
  unless PROMPTS.key?(prompt_id)
    puts "Invalid prompt_id. Available prompt_ids are: #{PROMPTS.keys.join(", ")}"
    exit
  end

  prompt = PROMPTS[prompt_id]

  # Create result directory if it doesn't exist
  FileUtils.mkdir_p('result')

  # Generate the requested number of images
  generate_images(concept, prompt, number_of_images)
end

# Call main function if script is run directly
main if __FILE__ == $0
