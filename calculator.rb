require_relative 'commands'

class Calculator
    attr_accessor :num1, :num2, :memory, :stack

    @@commands = {
        "+" => PlusCommand,
        "-" => MinusCommand,
        "*" => MultiplyCommand,
        "/" => DivideCommand,
        "mod" => AbsCommand,
        "pow" => PowCommand,
        "exp" => ExpCommand,
        "ln" => LnCommand,
        "!" => FactorialCommand,
        "mw" => MemoryWriteCommand,
        "mr" => MemoryReadCommand,
        "push" => StackPushCommand,
        "pop" => StackPopCommand,
        "primes" => PrimesCommand
    }

    def initialize()
        puts "Calculator has started"
        self.num1 = ask_num1()
        self.num2 = 0
        self.stack = []

        @commands = @@commands.transform_values { |command_class| command_class.new(self) }
    end

    def ask_num1()
        while true
            num1 = gets.chomp

            begin
                return Integer(num1)
            rescue ArgumentError
                puts "Помилка: це не число"
            end
        end
    end

    def ask_num2()
        while true
            num2 = gets.chomp

            begin
                return Integer(num2)
            rescue ArgumentError
                puts "Помилка: це не число"
            end
        end
    end

    def plus(num1, num2)
        num1 + num2
    end

    def minus(num1, num2)
        num1 - num2
    end

    def multiply(num1, num2)
        num1 * num2
    end

    def divide(num1, num2)
        if num2 != 0
            num1 / num2
        else
            puts "Помилка: ділення на нуль"
            nil
        end
    end

    def abs(num1)
        num1.abs
    end

    def pow(num1, num2)
        num1 ** num2
    end

    def negative(num1)
        -num1
    end

    def sqrt(num1)
        if num1 >= 0
            Math.sqrt(num1)
        else
            puts "Помилка: квадратний корінь з від'ємного числа"
            nil
        end
    end

    def sin(num1)
        rad = num1 * (Math::PI / 180)
        Math.sin(rad).round(10)
    end

    def cos(num1)
        rad = num1 * (Math::PI / 180)
        Math.cos(rad).round(10)
    end

    def tan(num1)
        rad = num1 * (Math::PI / 180)
        Math.tan(rad).round(10)
    end

    def ctan(num1)
        rad = num1 * (Math::PI / 180)
        if Math.tan(rad) != 0
            1 / Math.tan(rad).round(10)
        else
            puts "Помилка: котангенсу числа 0 не існує"
            nil
        end
    end

    def exp(num1)
        rad = num1 * (Math::PI / 180)
        Math.exp(rad).round(10)
    end

    def ln(num1)
        if num1 > 0
            rad = num1 * (Math::PI / 180)
            Math.log(rad).round(10)
        else
            puts "Помилка: натуральний логарифм існує лише для додатніх чисел"
            nil
        end
    end

    def factorial(num1)
        if num1 >= 0
            (1..num1).inject(1, :*)
        else
            puts "Помилка: факторіал існує лише для додатніх чисел"
            nil
        end
    end

    def memory_write(num1)
        self.memory = num1
    end

    def memory_read()
        self.memory
    end

    def stack_push(num1)
        self.stack << num1
    end

    def stack_pop()
        if stack.empty?
            "Помилка: стек порожній"
        else
            self.stack.pop
        end
    end

    def primes(num1, num2)
        primes = []
        if num2 > num1
            (num1+1..num2).each do |n|
                if n > 1 && (2..Math.sqrt(n)).none? { |i| n % i == 0 }
                    primes << n
                end
            end
        end
        primes.each do |prime|
            stack << prime
        end
        primes.last
    end

    def calculate()
        num1 = self.num1
        num2 = self.num2
        while true
            puts "Введіть операцію (+, -, *, /, mod, pow, --, sqrt, sin, cos, tan, ctan, exp, ln, !, mw (mem write), mr (mem read), stop,  primes, push, pop):"
            operator = gets.chomp

            result = nil
            case operator
                when "+"
                    num2 = ask_num2()
                    result = @commands["+"] .execute(num1, num2)

                when "-"
                    num2 = ask_num2()
                    result = @commands["-"] .execute(num1, num2)

                when "*"
                    num2 = ask_num2()
                    result = @commands["*"] .execute(num1, num2)

                when "/"
                    num2 = ask_num2()
                    result = @commands["/"] .execute(num1, num2)

                when "mod"
                    result = @commands["mod"] .execute(num1)

                when "pow"
                    num2 = ask_num2()
                    result = @commands["pow"] .execute(num1, num2)

                when "--"
                    result = @commands["--"] .execute(num1)

                when "sqrt"
                    result = @commands["sqrt"] .execute(num1)

                when "sin"
                    result = @commands["sin"] .execute(num1)

                when "cos"
                    result = @commands["cos"] .execute(num1)

                when "tan"
                    result = @commands["tan"] .execute(num1)

                when "ctan"
                    result = @commands["ctan"] .execute(num1)

                when "exp"
                    result = @commands["exp"] .execute(num1)

                when "ln"
                    result = @commands["ln"] .execute(num1)

                when "!"
                    result = @commands["!"] .execute(num1)

                when "mw"
                    @commands["mw"].execute(num1)
                    num1 = ask_num1()
                    next

                when "mr"
                    num1 = @commands["mr"].execute()
                    puts num1

                when "stop"
                    puts "Зупинка калькулятора"
                    break

                when "push"
                    @commands["push"].execute(num1)
                    puts num1
                    num1 = ask_num1()
                    next

                when "pop"
                    result = @commands["pop"].execute()

                when "primes"
                    num2 = ask_num2()

                    result = @commands["primes"].execute(num1, num2)
            end

            if result
                puts result

                num1 = result
            end
        end
    end
end


calculator = Calculator.new()

calculator.calculate()
