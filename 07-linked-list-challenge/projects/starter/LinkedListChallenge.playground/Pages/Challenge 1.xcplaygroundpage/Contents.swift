// Copyright (c) 2021 Razeware LLC
// For full license & permission details, see LICENSE.markdown.
/*:
 # Linked List Challenges
 ## Challenge 1: Print in reverse

 Create a function that prints the nodes of a linked list in reverse order.
 */
func printInReverse<T>(_ list: LinkedList<T>) {
  
    // probably use a while loop and removeLast until head = nil
    
//    var list = list
//
//    while let _ = list.head {
//        print("Remove last: \(list.removeLast()!)")
//    }
    
    printInReverse(list.head)
    
}

/// Any code that comes after the recursive call is called only after the base case triggers (i.e., after the recursive function hits the end of the list). As the recursive statements unravel, the node data gets printed out.
private func printInReverse<T>(_ node: Node<T>?) {
    
    guard let node = node else { return }

    printInReverse(node.next)
    print(node.value)
}

var list = LinkedList<Int>()

list.append(1)
list.append(2)
list.append(3)

printInReverse(list)
//: [Next Challenge](@next)
