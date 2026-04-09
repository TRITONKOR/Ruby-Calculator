class Command
  def initialize(object)
    @object = object
  end

  def execute
    raise NotImplementedError, "Subclasses must implement the execute method"
  end
end

class PlusCommand < Command
  def execute(num1, num2)
    @object.plus(num1, num2)
  end
end

class MinusCommand < Command
  def execute(num1, num2)
    @object.minus(num1, num2)
  end
end

class MultiplyCommand < Command
  def execute(num1, num2)
    @object.multiply(num1, num2)
  end
end

class DivideCommand < Command
  def execute(num1, num2)
    @object.divide(num1, num2)
  end
end

class AbsCommand < Command
  def execute(num1)
    @object.abs(num1)
  end
end

class PowCommand < Command
  def execute(num1, num2)
    @object.pow(num1, num2)
  end
end

class ExpCommand < Command
  def execute(num1)
    @object.exp(num1)
  end
end

class LnCommand < Command
  def execute(num1)
    @object.ln(num1)
  end
end

class FactorialCommand < Command
  def execute(num1)
    @object.factorial(num1)
  end
end

class MemoryWriteCommand < Command
  def execute(num1)
    @object.memory_write(num1)
  end
end

class MemoryReadCommand < Command
  def execute()
    @object.memory_read()
  end
end

class StackPushCommand < Command
  def execute(num1)
    @object.stack_push(num1)
  end
end

class StackPopCommand < Command
  def execute()
    @object.stack_pop()
  end
end

class PrimesCommand < Command
  def execute(num1, num2)
    @object.primes(num1, num2)
  end
end
