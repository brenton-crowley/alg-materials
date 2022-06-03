import Foundation

/*:
 # LinkedList
 
 A linked list has the concept of a head and tail.
 
 These refer to the first (head) and the last (tail) of the list.
 
 You could think of a catapillar and its body.
 
 */

public struct LinkedList<Value> {
    
    public var head: Node<Value>?
    public var tail: Node<Value>?
    
    public init() {}
    
    public var isEmpty: Bool { head == nil }
    
    private mutating func copyNodes() {
        
        // if this is a unique 
        guard !isKnownUniquelyReferenced(&head) else { return }
        
        guard var oldNode = head else { return }
        
        head = Node(value: oldNode.value)
        
        var newNode = head
        
        while let nextOldNode = oldNode.next {
            newNode!.next = Node(value: nextOldNode.value)
            newNode = newNode!.next
            
            oldNode = nextOldNode
        }
        
        tail = newNode
    }
    
    private mutating func copyNodes(returningCopyOf node: Node<Value>?) -> Node<Value>? {
        
        guard !isKnownUniquelyReferenced(&head) else { return nil }
        
        guard var oldNode = head else { return nil }
        
        head = Node(value: oldNode.value)
        var newNode = head
        var nodeCopy: Node<Value>?
        
        while let nextOldNode = oldNode.next {
            
            if oldNode === node {
                nodeCopy = newNode
            }
            newNode!.next = Node(value: nextOldNode.value)
            newNode = newNode!.next
            oldNode = nextOldNode
            
        }
        
        return nodeCopy
    }
}

extension LinkedList: CustomStringConvertible {
    
    public var description: String {
        
        guard let head = head else {
            return "Empty list"
        }
        
        return String(describing: head)
    }
    
}

/*:
 Three ways that you can add items to a linked list.
 
 1. Push an item onto the front of the list.
 2. Append an item to the end of the list.
 3. Insert an item after a particular item.
    
 ### Push
 
 ### Time complexity
 O(1) Constant as we're modifying the start of the list.
 Because each item just contains a reference to the next, we're NOT shuffling values.
 We're just changing the values of a couple of nodes.
 
 */

extension LinkedList {
    
    public mutating func push(_ value:Value) {
        copyNodes()
        // by default, the incoming value will become the head.
        head = Node(value: value, next: head)
        
        // if no items, then the tail also becomes the head
        if tail == nil { tail = head }
    }
    
}

/*:
 ### Append
 
 Adds a value to the end of the list.
 
 ### Time complexity
 O(1) Constant as we're modifying the end of the list.
 
 */

extension LinkedList {
    
    public mutating func append(_ value: Value) {
        
        copyNodes()
        
        // Make sure that the list already has a value,
        // if not, then push the value
        guard !isEmpty else { push(value); return }
        
        // We know we have at least one value,
        // assign a new Node to the next prop of the tail.
        tail!.next = Node(value: value)
        
        // Assign a new tail to be the next value of the current tail.
        // I guess this just saves having to create more variables.
        tail = tail!.next
    }
    
}

/*:
 ### Insert after node
 
 Inserts a node at a particular place in the list and requires two steps.
 
 1. Find a node in the list.
 2. Insert the new node.
 
 It doesn't need to update all the next node after an insertion as they're already linked.
 You just need to change the next property of the 'index at' node to be that of the new node.
 Capture the currentNode's next value so that you can assign it as the new node's next value.
 
 ### Time complexity
 O(1) Constant
 Again, we're just changing property references.
 \
 */

extension LinkedList {
    
    /// Attempts to find a node at a given index.
    /// If no node at that index, returns nil
    ///
    /// ### Time complexity
    /// O(i) where i is the index of the given index.
    /// In other words, the larger the index, the longer it takes.
    /// That's due to looking through the while loop.
    ///
    /// - Parameter index: The position of the node you wish to select.
    /// - Returns: Either the node at the index or nil if node doesn't exist at that index.
    public mutating func node(at index:Int) -> Node<Value>? {
        
        // Two helper variables.
        var currentNode = head // starting node
        var currentIndex = 0 // keep track of where it is
        
        // Loop through until either the current node is nil or the currentIndex is no longer less than index
        while currentNode != nil && currentIndex < index {
            currentNode = currentNode!.next // continues if not nil
            currentIndex += 1
        }
        
        return currentNode
    }
    
    @discardableResult // suppress warning if we don't use the result
    /// Assigns the node's next property to a new node with the supplied value
    /// - Parameters:
    ///   - value: The value of the new node.
    ///   - node: The preceding node before the new value.
    /// - Returns: The new node containing value.
    public mutating func insert(_ value: Value,
                                after node: Node<Value>) -> Node<Value> {
        copyNodes()
        // check to see if the last node is not the node one we want to indert after.
        // If it is the tail node, then we can just append.
        guard tail !== node else {
            append(value)
            return tail!
        }
        
        // create the new node.
        /// 1. Create a new node.
        /// 2. Assign the new node's `next` property value to be the currentNode's `next` value.value
        /// 3. Reassign the `next` property of the currentNode to be the new node.
        node.next = Node(value: value, next: node.next)
        return node.next!
    }
}

/*:
 ## Removing values from the list
 
 1. pop // removes the first item
 2. removeLast
 3. remove at index
 
 ### Pop

 ### Time Complexity
 
 */



extension LinkedList {
    
    @discardableResult
    public mutating func pop() -> Value? {
        
        copyNodes()
        // Swift's defer keyword lets us set up some work to be performed when the current scope exits.
        // In other words, after the end of the function.
        // 1. We'll return the value we're removing.
        // 2. The function scope completes.
        // 3. Runs the deferred code
        defer {
            head = head?.next // assigns head to be the next node. Basically, discard the first. If no next node, then head will be nil.
            if isEmpty { tail = nil } // If head is nil, we're empty, so tail must also be nil.
        }
        
        return head?.value
    }
}

/*:
 
 ## removeLast
 
 ### Time complexity
 O(n) where n is the size of the linked list.
 That's because we need to traverse through the list to find the last two items.
 
 */
extension LinkedList {
    
    @discardableResult
    public mutating func removeLast() -> Value? {
        
        copyNodes()
        // how do we get the last item?
        // we have access to tail
        // we need to set the node before tail to be the new tail, if it exists.
        
        // these two checks save on traversal
        
        // if we don't have a head, then no value to return
        guard let head = head else { return nil }
        
        // we have a head, now check if we have a next value
        // if next value is nil, then we have just one item.
        // utilise the pop() to return the first item
        guard head.next != nil else { return pop() }
        
        // traverse the linked list to find the item before the tail
        
        var previous = head // start element
        var current = head
        
        // while we have a non-nil next node, continue to reassign previous to the current node and current to the next node.
        // once we arrive at the tail, we won't have a next. Use the previous and current values.
        while let next = current.next {
            previous = current
            current = next
        }
        
        previous.next = nil
        tail = previous
        
        return current.value
    }
    
}

/*:
## removeLast

 ### Time complexity
 O(1) because we're just reassign linkages.
 BUT you need to have a reference to the node which uses the node(at index) and that is O(n)
 So it really is O(n)

*/
extension LinkedList {
    
    @discardableResult
    // removes a node after the supplied node.
    public mutating func remove(after node:Node<Value>) -> Value? {
        
        guard let node = copyNodes(returningCopyOf: node) else { return nil }
        
        
        defer {
            
            // if the next node is the tail, reassign the tail to be the supplied node.
            if node.next === tail { tail = node }
            
            // reassign the next node to be the one after the next. If no node exists, we're at the tail and it will result to nil.
            node.next = node.next?.next
        }
        
        return node.next?.value
    }

}

extension LinkedList: Collection {
    
    public struct Index: Comparable {
        
        public var node: Node<Value>?
        
        static public func ==(lhs: Index, rhs: Index) -> Bool {
            
            switch (lhs.node, rhs.node) {
            case let (left?, right?):
                return left.next === right.next
            case (nil, nil):
                return true
            default:
                return false
            }
        }
        
        static public func <(lhs: Index, rhs: Index) -> Bool {
            guard lhs != rhs else { return false }
            
            // I need to understand this
            let nodes = sequence(first: lhs.node) { $0?.next }
            return nodes.contains { $0 === rhs.node }
        }
    }
    
    public var startIndex: Index { Index(node: head) }
    
    public var endIndex: Index { Index(node: tail?.next) }
    
    public func index(after i: Index) -> Index { Index(node: i.node?.next) }
    
    public subscript(position: Index) -> Value { position.node!.value }
}
