# frozen_string_literal: true

require 'spec_helper'

describe 'IAM_CloudManager' do
  before(:all) do
    @aws_iam_role = resource('aws_iam_role')
  end
end
