// Copyright (c) 2021 Razeware LLC
// For full license & permission details, see LICENSE.markdown.
/*:
 [Previous Challenge](@previous)
 ## Challenge 3: Reverse a linked list

 Create a function that reverses a linked list. You do this by manipulating the nodes so that they’re linked in the other direction.
 */
extension LinkedList {
    
  mutating func reverse() {
    
      guard let first = head else { return }
      
      // start at the head
      var currentNode = first
      
      // keep going until we land at the end.
      while let next = currentNode.next {
          currentNode.next = currentNode
          currentNode = next
      }
  }

}

example(of: "reverse") {
    
    var list = LinkedList<Int>()
    
    (1...11).forEach { list.append($0) }
    
    print("Before reverse: \(list)")
    
    list.reverse()
    
    print("After reverse: \(list)")
}

//: [Next Challenge](@next)
