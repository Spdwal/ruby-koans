require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutArrays < Neo::Koan
  def test_creating_arrays
    empty_array = Array.new
    assert_equal Array, empty_array.class
    assert_equal 0, empty_array.size
  end

  def test_array_literals
    array = Array.new
    assert_equal [], array

    array[0] = 1
    assert_equal [1], array
    # 直接赋值，会增加array的size
    array[1] = 2
    assert_equal [1, 2], array

    array << 333
    assert_equal [1, 2, 333], array
  end

  def test_accessing_array_elements
    array = [:peanut, :butter, :and, :jelly]

    assert_equal :peanut, array[0]
    assert_equal :peanut, array.first
    assert_equal :jelly, array[3]
    assert_equal :jelly, array.last
    # 类似pyhon，index < 0时，从右往左数
    assert_equal :jelly, array[-1]
    assert_equal :butter, array[-3]
  end

  def test_slicing_arrays
    array = [:peanut, :butter, :and, :jelly]
    # array[start, length],第一个参数是起始index，第二个参数是数组长度
    assert_equal [:peanut], array[0,1]
    assert_equal [:peanut, :butter], array[0,2]
    assert_equal [:and, :jelly], array[2,2]
    # 超出范围的忽略
    assert_equal [:and, :jelly], array[2,20]
    # array[4] == nil
    assert_equal [], array[4,0]
    # 超出范围
    assert_equal [], array[4,100]
    # 此处略微不一样，区别在哪里，文档没查出来
    # 经过数次实验，array[array.size, number] == []
    # array[number WHERE number > array.size, another_number] = nil
    # 在源码中找到以下描述：
    # If +start+ is non-negative and outside the array (<tt> >= self.size</tt>),
    # extends the array with +nil+, assigns +object+ at offset +start+,
    # and ignores +length+:
    assert_equal nil, array[5,0]
  end

  def test_arrays_and_ranges
    # (1..5) => (1..5) 他是Range类型，而不是Range类型e
    assert_equal Range, (1..5).class
    assert_not_equal [1,2,3,4,5], (1..5)
    assert_equal [1,2,3,4,5], (1..5).to_a
    assert_equal [1,2,3,4], (1...5).to_a
  end

  def test_slicing_with_ranges
    array = [:peanut, :butter, :and, :jelly]
    # 没什么好说的，简单的数组range
    assert_equal [:peanut, :butter, :and], array[0..2]
    assert_equal [:peanut, :butter], array[0...2]
    assert_equal [:and, :jelly], array[2..-1]
  end

  def test_pushing_and_popping_arrays
    array = [1,2]
    array.push(:last)

    assert_equal [1, 2, :last], array

    # push pop是栈结构
    popped_value = array.pop
    assert_equal :last, popped_value
    assert_equal [1, 2], array
  end

  def test_shifting_arrays
    array = [1,2]
    # unshift 相当于队列的 push_front
    array.unshift(:first)

    assert_equal [:first, 1, 2], array

    # shift 相当于队列的 pop_front
    shifted_value = array.shift
    assert_equal :first, shifted_value
    assert_equal [1, 2], array
  end

end
