#
# InfixPostfix class contains methods for infix to postfix conversion and
# postfix expression evaluation.
#
class InfixPostfix
  
	# converts the infix expression string to postfix expression and returns it
	# FIXME - Broken on jag's second test case
	def infixToPostfix(exprStr)
		postfix = ""
		stack = []
		tokens = exprStr.split(" ")
		
		for t in tokens do
			if operand?(t)
				postfix << t << " "
			elsif operator?(t)
				# pop operators (if there are any) from the stack with "stack precedence" equal or higher than the "input precedence" of the current token, and append popped operators to the postfix expression
				postfix << stack.pop << " " while stack.length > 0 and stackPrecedence(stack.last) >= inputPrecedence(t)
					
				# push the current token onto the stack
				stack.push t
			elsif isLeftParen?(t)
				stack.push t
			elsif isRightParen?(t)
				# pop operators from the stack and append them to postfix expression until a left parenthesis is at the top of the stack
				postfix << stack.pop << " " while stack.length > 0 and stack.last != '('
				
				# pop and discard the left parenthesis
				if stack.length > 0
					stack.pop
				end
			end
		end
		
		# pop the remaining operators from the stack and append them to postfix expression
		postfix << stack.pop << " " while stack.length > 0
		
		postfix
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

				stack.push applyOperator(x, y, t).to_s
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
		!!Float(str) rescue false
	end
	  
	# returns true if the input is a left parenthesis and false otherwise
	def leftParen?(str)
		str == '('
	end
	  
	# returns true if the input is a right parenthesis and false otherwise
	def rightParen?(str)
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
		num1 = Integer(num1)
		num2 = Integer(num2)
		result = 0
		
		if operator?(op)
			result = case op
				when '+' then return num1 + num2
				when '-' then return num1 - num2
				when '*' then return num1 * num2
				when '/' then return num1 / num2
				when '%' then return num1 % num2
				when '^' then return num1 ** num2
				#else -> throw some sort of error so we don't get nil
			end
		end
		
		result
	end
end

#
#  main driver for the program - similar to the main() function in Project 2
#
puts "(1) Convert Infix to Postfix Expression\n"
puts "(2) Evaluate Postfix Expression\n"
puts "(3) Quit\n"
puts "Enter Selection (1, 2, or 3): "
	
convert = InfixPostfix.new
choice = ""
	
while choice != '3'
	choice = gets.chomp
	
	case choice
		when '1'
			puts "Enter infix notation: "
			postfix = convert.infixToPostfix(gets);
			puts "Postfix: " << postfix << "\n"
			puts "Value: " << convert.evaluatePostfix(postfix) << "\n"
		when '2'
			puts "Enter prefix notation: "
			puts "Value: " << convert.evaluatePostfix(gets).to_s << "\n"
		when '3'
			puts "Bye, thanks for using"
		else
			puts "Invalid selection, try again\n"
	end
end
