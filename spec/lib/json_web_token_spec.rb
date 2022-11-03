require 'rails_helper'
require 'json_web_token'

RSpec.describe JsonWebToken do
  let(:payload) { {id: 1} }

  describe '#encode' do
    it 'returns an encoded string of the payload' do
      expect(described_class.encode(payload)).not_to be_nil
    end
  end

  describe '#decode' do
    let(:encoded_payload) { described_class.encode(payload) }

    it 'returns a decoded hash' do
      expect(described_class.decode(encoded_payload).is_a?(Hash)).to be_truthy
    end

    it 'returns a valid hash' do
      expect(described_class.decode(encoded_payload).keys).to include('id', 'exp')
    end

    it 'returns a valid expiration' do
      expect(described_class.decode(encoded_payload)[:exp]).to be > Time.now.to_i
    end
  end
end
