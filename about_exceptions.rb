require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutExceptions < Neo::Koan

  class MySpecialError < RuntimeError
  end

  def test_exceptions_inherit_from_Exception
    assert_equal MySpecialError, MySpecialError.ancestors[0]
    assert_equal RuntimeError, MySpecialError.ancestors[1]
    assert_equal StandardError, MySpecialError.ancestors[2]
    assert_equal Exception, MySpecialError.ancestors[3]
    assert_equal Object, MySpecialError.ancestors[4]
    assert_equal Kernel, MySpecialError.ancestors[5]
  end

  def test_rescue_clause
    result = nil
    begin
      # fails String 会抛出一个RuntimeError message 为String参数
      fail "Oops"
    rescue StandardError => ex
      result = :exception_handled
    end

    assert_equal :exception_handled, result

    assert_equal true, ex.is_a?(StandardError), "Should be a Standard Error"
    assert_equal true, ex.is_a?(RuntimeError),  "Should be a Runtime Error"
    assert RuntimeError.ancestors.include?(StandardError),
      "RuntimeError is a subclass of StandardError"

    assert_equal "Oops", ex.message
  end

  def test_raising_a_particular_error
    result = nil
    begin
      # 'raise' and 'fail' are synonyms
      raise MySpecialError, "My Message"
    rescue MySpecialError => ex
      result = :exception_handled
    end

    assert_equal :exception_handled, result
    assert_equal "My Message", ex.message
  end

  def test_ensure_clause
    result = nil
    begin
      fail "Oops"
    rescue StandardError
    # no code here
    # ensure 跟在resue后面，一定会运行
    ensure
      result = :always_run
    end

    assert_equal :always_run, result
  end

  # Sometimes, we must know about the unknown
  def test_asserting_an_error_is_raised
    # A do-end is a block, a topic to explore more later
    assert_raise(MySpecialError) do
      raise MySpecialError.new("New instances can be raised directly.")
    end
  end

end
