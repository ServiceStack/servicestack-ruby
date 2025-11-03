# frozen_string_literal: true

require "test_helper"

class ServiceStackTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::ServiceStack::VERSION
  end

  def test_version_is_a_string
    assert_instance_of String, ::ServiceStack::VERSION
  end
end
