# Drawing Shapes
# You're provided with a base Shape class, and a Square class which extends it. You can see how the Square class works by modifying the test code:
# s = Answer.Square()
# s.print()
# The output is an ASCII art square:
# ####
# ####
# ####
# ####
# Fill in the class Triangle to print a triangle to the console. Can you print a right-angle triangle?
# Try modifying the height and width of your triangle as well. Feel free to change how the base class is called! 
# For example, you may want to make height and width instance attributes that are passed into the constructor, rather than static attributes on the base class.

class Shape:
	width = 5
	height = 5
	printChar = '#'

	def printRow(self, i):
		raise NotImplementedError("Will be implemented by children extending this class")

	def print(self):
		for i in range(self.height):
			self.printRow(i)


class Square(Shape):
	def printRow(self, i):
		print(self.printChar * self.width)

class Triangle(Shape):   
    def printRow(self, i):
        print(self.printChar * (i + 1))

myShape = Triangle()

myShape.print()