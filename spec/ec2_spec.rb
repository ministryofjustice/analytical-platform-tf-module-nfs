# frozen_string_literal: true

require 'spec_helper'

describe 'EC2_CloudManager' do
  before(:all) do
    @aws_ec2_instance = resource('aws_instance')
    @aws_security_group = resource('aws_security_group')
  end

  context 'Instance' do
    context 'Have_Metadata' do
      it 'should have instance metadata' do
        expect(@aws_ec2_instance).not_to be_nil
      end
    end

    context 'Metadata' do
      it 'should have a public IP' do
        has_public_ip = @aws_ec2_instance['values']\
        ['associate_public_ip_address']
        expect(has_public_ip).to eq true
      end

      it 'should have required tags' do
        tag_keys = []
        expected_tag_keys = %w[Name application business-unit is-production
                               owner]
        @aws_ec2_instance['values']['tags'].each do |key, _value|
          tag_keys << key
        end
        actual_tag_keys = tag_keys.flatten.uniq
        expect(actual_tag_keys).to eq expected_tag_keys
      end
    end
  end
end
