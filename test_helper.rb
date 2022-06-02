class ExpectationNotMetError < StandardError
end

def assert_equal(expected, &actual)
  print_errors(1) do
    result = actual.call

    raise ExpectationNotMetError, "Expected #{expected.inspect}, got #{result.inspect}" if result != expected

    puts "ok"
  end
end

def assert_error(klass, &actual)
  print_errors(2) do
    actual.call
  rescue => e
    raise ExpectationNotMetError, "Expected #{e} to be an instance of #{klass}, but got #{e.class}" if e.class != klass
    puts "ok"
  else
    puts "Expected #{klass} error to be raised, but nothing was raised"
  end
end

def assert_klass(klass, &actual)
  print_errors(1) do
    result = actual.call

    raise ExpectationNotMetError, "Expected #{result.inspect}, to be an instance of #{klass}, but is an instance of #{result.class}" unless result.is_a?(klass)

    puts "ok"
  end
end

def print_errors(starting_index, &check)
  yield
rescue ExpectationNotMetError => e
  puts e
  puts e.backtrace[starting_index..].map { |line| "  #{line}" }
end
