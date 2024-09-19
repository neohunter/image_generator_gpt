# Image Generator with OpenAI API

This project is a Ruby application that generates images using the OpenAI API. You can use predefined prompts or generate samples based on a custom prompt.

## Installation

1. Clone the repository.
2. Run `bundle install` to install dependencies.
3. Set your OpenAI API key as an environment variable:

```bash
export OPENAI_API_KEY="your-openai-api-key"
```

## Usage

### Generate Images

```bash
ruby image_generator.rb <number_of_images> <keyword> <concept>
```

Example:

```bash
ruby image_generator.rb 5 futuristic_scape "Cyberpunk City"
```

### Generate Samples

Generate 3 samples for each keyword using a custom prompt:

```bash
ruby image_generator.rb generate_samples "a dog dancing"
```

## Running Tests

Run the tests using `rake`:

```bash
rake
```

## License

MIT License
