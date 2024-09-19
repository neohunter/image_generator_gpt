require_relative '../lib/image_generator'
require_relative '../lib/openai_client'
require_relative '../lib/prompts'

RSpec.describe ImageGenerator do
  let(:client) { instance_double(OpenAIClient) }
  let(:generator) { ImageGenerator.new(client) }

  describe '#generate_images' do
    it 'downloads and saves images' do
      allow(client).to receive(:generate_images).and_return({'data' => [{'url' => 'http://example.com/image.png'}]})
      allow(client).to receive(:download_image).and_return('image_content')

      generator.generate_images('TestConcept', 'TestPrompt', 1, 'test_result', 'test_image')

      expect(File).to exist('test_result/test_image_1.png')
      File.delete('test_result/test_image_1.png') # Clean up after the test
    end
  end

  describe '#generate_samples' do
    it 'generates 3 samples for each keyword' do
      allow(client).to receive(:generate_images).and_return({'data' => [{'url' => 'http://example.com/image.png'}]})
      allow(client).to receive(:download_image).and_return('image_content')

      generator.generate_samples('Custom sample')

      Prompts::LIST.keys.each do |keyword|
        expect(File).to exist("samples/#{keyword}_1.png")
        File.delete("samples/#{keyword}_1.png") # Clean up after the test
      end
    end
  end
end
