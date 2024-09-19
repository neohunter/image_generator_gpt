require_relative './lib/image_generator'
require_relative './lib/prompts'
require_relative './lib/openai_client'

# Main function to process the arguments
def main
  if ARGV.size == 2 && ARGV[0] == 'generate_samples'
    sample_prompt = ARGV[1]
    generator = ImageGenerator.new
    generator.generate_samples(sample_prompt)
    return
  end

  if ARGV.size != 3
    puts "Usage: ruby image_generator.rb <number_of_images> <keyword> <concept>"
    puts "Or: ruby image_generator.rb generate_samples \"custom prompt\""
    exit
  end

  number_of_images = ARGV[0].to_i
  keyword = ARGV[1]
  concept = ARGV[2]

  # Ensure valid keyword
  unless Prompts::LIST.key?(keyword)
    puts "Invalid keyword. Available keywords are: #{Prompts::LIST.keys.join(", ")}"
    exit
  end

  prompt = Prompts::LIST[keyword]
  generator = ImageGenerator.new
  generator.generate_images(concept, prompt, number_of_images)
end

# Call main function if script is run directly
main if __FILE__ == $0
