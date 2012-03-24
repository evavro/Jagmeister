#!/usr/bin/ruby -w

#
# InfixPostfix class contains methods for infix to postfix conversion and
# postfix expression evaluation.
#
class InfixPostfix
  
	# converts the infix expression string to postfix expression and returns it
	def infixToPostfix(exprStr)
		postfix = ""
		stack = []
		tokens = exprStr.split(" ")
		
		for t in tokens do
			if operand?(t)
				postfix << t << " "
			elsif operator?(t)
				# Pop operators (if there are any) from the stack with "stack precedence" equal or higher than the "input precedence" of the current token, and append popped operators to the postfix expression
				while stack.length > 0 and stackPrecedence(stack.last) >= inputPrecedence(t)
					postfix << stack.pop << " "
				end
					
				# Push the current token onto the stack.
				stack.push t
			elsif isLeftParen?(t)
				stack.push t
			elsif isRightParen?(t)
				# Pop operators from the stack and append them to postfix expression until a left parenthesis is at the top of the stack.
				while stack.length > 0 and stack.last != '('
					postfix << stack.pop << " "
				end
				
				# Pop and discard the left parenthesis
				if stack.length > 0
					stack.pop
				end
			end
		end
	end
	  
	# evaluate the postfix string and returns the result
	def evaluatePostfix(exprStr)
		x, y = 0
		stack = []
		tokens = exprStr.split(" ")
		
		for t in tokens do
			if operand?(t)
				stack.push t
			elsif operator?(t)
				y = stack.pop
				x = stack.pop

				stack.push applyOperator(x, y, t)
			end
		end
		
		# return the final result
		stack.pop
	end
	  
	private # subsequent methods are private methods
	  
	# returns true if the input is an operator and false otherwise
	def operator?(str)
		['+', '-', '*', '%', '/', '^'].include? str
	end
	  
	# returns true if the input is an operand and false otherwise
	def operand?(str)
		str.is_numeric
	end
	  
	# returns true if the input is a left parenthesis and false otherwise
	def isLeftParen?(str)
		str == '('
	end
	  
	# returns true if the input is a right parenthesis and false otherwise
	def isRightParen?(str)
		str == ')'
	end
	  
	# returns the stack precedence of the input operator
	def stackPrecedence(op)
		if op == '+' or op == '-' then 1
			elsif op == '*' or op == '/' or op == '%' then 2
			elsif op == '^' then 3
			elsif op == '(' then -1
		end
	end
	  
	# returns the input precedence of the input operator
	def inputPrecedence(op)
		if op == '+' or op == '-' then 1
			elsif op == '*' or op == '/' or op == '%' then 2
			elsif op == '^' then 4
			elsif op == '(' then 5
		end
	end
	  
	# applies the operators to num1 and num2 and returns the result
	def applyOperator(num1, num2, op)
		case operator?(op)
			when op == '+' then num1 + num2
			when op == '-' then num1 - num2
			when op == '*' then num1 * num2
			when op == '/' then num1 / num2
			when op == '%' then num1 % num2
			when op == '^' then num1 ** num2
		end
	end
end

#
#  main driver for the program - similar to the main() function in Project 2
#
def main()
  
end

# invoke main function
main()
