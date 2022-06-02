// Copyright (c) 2021 Razeware LLC
// For full license & permission details, see LICENSE.markdown.


/*:
 
 # Stack
 
 A stack is a data structure that contains a list of elements from top to bottom.
 Elements are pushed onto the TOP of the stack.
 Elements are popped from the TOP of the stack.
 If you are LAST IN then you are FIRST OUT (LIFO)

 ## Time Complexity
 A stack is an O(1) because it utilises an array's append() and popLast() methods.
 In other words, under the hood, you add and remove elements from the end of the array.
 But it looks like you are doing it from the front.

 Stacks are crucial to problems that search trees and graphs.
 */


public struct Stack<Element> {
    
    private var storage: [Element] = []
    
    public init() { }
    
}

extension Stack: CustomDebugStringConvertible {
    
    public var debugDescription: String {
        
        """
        ----top----
        \(storage.map { "\($0)" }.reversed().joined(separator: "\n"))
        -----------
        """
        
    }
    
    public mutating func push(_ element:Element) { storage.append(element) }
    
    @discardableResult
    public mutating func pop() -> Element? { storage.popLast() }
    
    public func peek() -> Element? { storage.last }
    
    public var isEmpty:Bool { peek() == nil }
    
    public init(_ elements: [Element]) { storage = elements }
    
}

extension Stack: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Element...) {
        storage = elements
    }
}

example(of: "using a stack") {
    var stack = Stack<Int>()
    stack.push(1)
    stack.push(2)
    stack.push(3)
    stack.push(4)
    
    print(stack)
    
    if let poppedElement = stack.pop() {
        assert(4 == poppedElement)
        print("Popped: \(poppedElement)")
    }
}

example(of: "initialising a stack from an array") {
    let array = ["A", "B", "C", "D"]
    var stack = Stack(array)
    print(stack)
    stack.pop()
}

example(of: "initialsing a stack from an array literal") {
    var stack: Stack = [1.0, 2.0, 3.0, 4.0]
    print(stack)
    stack.pop()
}

example(of: "print elements of an array in reverse order") {
    
    let array = [1, 2, 3, 4, 5]
    dump(array)
    var stack = Stack(array)
    
    print("Reversed Order")
    while let item = stack.pop() {
        print(item)
    }
}

extension String {
    
    // true until proven otherwise
    func hasBalancedParentheses() -> Bool {
           
        var stack = Stack<Character>()
        
        // loop through each character of the string.
        for char in self {
            
            // if (, create a new stack with (
            if char == "(" { stack.push(char) }

            // if ), pop the last item in the stack
            if char == ")" {
                // if nothing left to remove, then we don't have an open parentheses to match the closed, so we're false
                guard let _ = stack.pop() else { return false }
            }
            
        }
        
        return stack.isEmpty
    }
}

example(of: "Balanced parentheses tests") {
    
     // true
    "(())".hasBalancedParentheses() // true
    "(()".hasBalancedParentheses() // false
    ")(".hasBalancedParentheses() // false
    "(".hasBalancedParentheses() // false
    "()()()".hasBalancedParentheses() // true
    "(1(2(3)(4(5))))".hasBalancedParentheses() // true
    "(1(2(3)(4(5)))))".hasBalancedParentheses() // false
    "".hasBalancedParentheses() // true
    "    ".hasBalancedParentheses() // true
}

