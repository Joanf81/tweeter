require 'test_helper'

class TagTest < ActiveSupport::TestCase

  # Valid attributes
  test "should save valid tag" do
    tag = Tag.new({tag: 'tag4'})

    assert tag.save
    assert Tag.exists?(tag.id)
  end


  # Valid attributes
  test "should not save empty tag" do
    tag = Tag.new({})

    assert_not tag.save
    assert_not Tag.exists?(tag.id)
  end

  test "should not save duplicated tag" do
    tag = Tag.new({tag: 'tag1'})

    assert_not tag.save
    assert_not Tag.exists?(tag.id)
  end

  test "should not save invalid tag" do
    tag = Tag.new({tag: 'tag4&%$'})

    assert_not tag.save
    assert_not Tag.exists?(tag.id)
  end

end
