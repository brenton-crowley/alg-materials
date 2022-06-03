// Copyright (c) 2021 Razeware LLC
// For full license & permission details, see LICENSE.markdown.
/*:
 [Previous Challenge](@previous)
 ## Challenge 2: Find the middle node

 Create a function that finds the middle node of a linked list.
 */
func getMiddle<T>(_ list: LinkedList<T>) -> Node<T>? {
    
    
    // if the list has no head, then no middle
    guard list.head != nil else { return nil }
    
    var index = 0
    var currentNode = list.head
    
    // get the total items
    while let nextNode = currentNode?.next {
        index += 1
        currentNode = nextNode
    }
    
    let middleIndex = Int( (Double(index) / 2.0).rounded(.awayFromZero) )
    
    return list.node(at: middleIndex)
}

var list = LinkedList<Int>()

(1...11).forEach { list.append($0) }

print(list)

if let middle = getMiddle(list) { print("Middle: \(middle.value)") }

func getMiddleRunner<T>(_ list: LinkedList<T>) ->Node<T>? {
    
    guard list.head != nil else { return nil }
    
    var slow = list.head
    var fast = list.head
    
    while let nextFast = fast?.next {
        fast = nextFast.next // will reach the end quicker
        slow = slow?.next
    }
        
    return slow
}

example(of: "getting the middle node") {
  var list = LinkedList<Int>()
  
  (1...11).forEach { list.append($0) }

  print(list)

  if let middleNode = getMiddleRunner(list) {
      print(middleNode.value)
  }
}

//: [Next Challenge](@next)
