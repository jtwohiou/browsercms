require 'test_helper'

# These Form Block classes cannot be defined within the FormBlockTest class. Something
# related to the dynamic attributes causes other tests to fail otherwise.
class NoInlineFormBlock < Cms::FormBlock
  render_inline false
end

class InlineFormBlock < Cms::FormBlock
end

class NonEditableFormBlock < Cms::FormBlock
  enable_template_editor false
end

class EditableFormBlock < Cms::FormBlock
  enable_template_editor true
end


class FormBlockTest < ActiveSupport::TestCase

  def setup
    @form_block = create(:form_block)

  end

  test "Users should able_to_modify? form block" do
    user = create(:content_editor)
    assert_equal [], Cms::FormBlock.new.connected_pages
    assert user.able_to_modify?(Cms::FormBLock.new)

  end

  test "destroy should mark a form block as deleted" do
    @form_block.destroy
    @form_block.reload!
    assert_equal true, @form_block.deleted?
  end

  test "update_attributes" do
    @form_block.update_attributes(:b => "whatever")
    assert_equal "whatever", @form_block.b
  end

  test "attributes=" do
    @form_block.attributes=({:b => "b"})
    assert_equal "b", @form_block.b
  end

  def test_dynamic_attributes
    form_block = DynamicFormBlock.create(:name => "Test", :foo => "FOO")
    assert_equal "FOO", Cms::FormBlock.find(form_block.id).foo
    assert_equal "Dynamic FormBlock", form_block.form_bock_type_name
  end

  def test_form_blocks_consistently_load_the_same_number_of_types

    list = Cms::FormBlock.types
    assert list.size > 0

    DynamicFormBlock.create!(:name=>"test 1")
    DynamicFormBlock.create!(:name=>"test 2")

    assert_equal list.size, Cms::FormBlock.types.size
  end


  test "render_inline" do
    assert_equal false, NoInlineFormBlock.render_inline
  end

  test "FormBlock should default to render_inline is true" do
    assert InlineFormBlock.render_inline
  end

  test "allow_template_editing" do
    assert_equal true, EditableFormBlock.render_inline

    assert_equal false, NonEditableFormBlock.render_inline
  end

  test "If render_inline is true, should return the value of 'template'" do
    p = EditableFormBlock.new
    p.template = "<b>CODE HERE</b>"

    assert_equal p.template, p.inline_options[:inline]
  end
  test "If render_inline is true, but template is blank, don't render inline" do
    p = EditableFormBlock.new

    p.template = nil
    assert_equal({}, p.inline_options)

    p.template = ""
    assert_equal({}, p.inline_options)
  end

  test "Form Blocks should be considered 'connectable?, and therefore can have a /usages route.'" do
    assert Cms::FormBlock.connectable?
  end
end
