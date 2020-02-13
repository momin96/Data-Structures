
//  Created by Nasir Ahmed Momin on 18/01/20.
//  Copyright © 2020 Nasir Ahmed Momin. All rights reserved.

// Implementation of Singly linked list in Swift
class Node<T> {
    
    var data: T?
    var next: Node<T>?
    
    init(_ data: T) {
        self.data = data
    }
}

enum ListDirection {
    case left
    case right
}

struct SinglyLinkedList<T: Equatable> {
    
    // If nil, then there is NO node in list sequence
    var firstNode: Node<T>?
    
    // Adds data/Item by creating node from specified direction.
    mutating func add(anItem item: T, from d: ListDirection) {
        
        // Create node by supplied data, to be added in list
        let newNode = Node<T>(item)
        
        // Validation check for node list does NOT exist, if true then, make new node as firstNode
        if firstNode == nil {
            self.firstNode = newNode
        }
        else {
            
            // Obtain firstNode reference.
            var tempNode = self.firstNode
            
            if d == .left { // Validation check for data insertion from Left side.
                
                // Make tempNode as next sequence for newly created node.
                newNode.next = tempNode
                
                // Make newNode as first node, so that new data empbed on left side.
                self.firstNode = newNode
                
            }
            else if d == .right { // Validation check for data insertion from Right side.
                
                // Note that first node is never manipulated in this clause.
                
                // Traverse till it reaches nil
                while tempNode?.next != nil {
                    tempNode = tempNode?.next
                }
                
                // Then insert new node from right side.
                tempNode?.next = newNode
            }
        }
    }
    
    // Remove item from from specified direction.
    mutating func remove(from d: ListDirection) -> Node<T>? {
        
        var nodeToBeRemoved: Node<T>?
        
        // return nil, incase of NO sequence exist
        if self.firstNode == nil {
            return nil
        }
        
        var nextNode = self.firstNode
        
        if d == .left {
            // Makes sure firstNode's next node becomes firstNode. so that firstNode from left side can be removed.
            self.firstNode = nextNode?.next
            nodeToBeRemoved = nextNode
        }
        else if d == .right {
        
            // Maintains a previous node, so that connection for node to be removed is deleted.
            var prevnode: Node<T>? = self.firstNode
            
            // Traverse till it reaches nil node
            while nextNode?.next != nil {
                
                // Both points to same node, then next node is incremented to point to next of next
                prevnode = nextNode
                nextNode = nextNode?.next
            }
            
            // Connection deleting for node to be removed
            prevnode?.next = nil
            nodeToBeRemoved = nextNode
        }
        
        return nodeToBeRemoved
    }
    
    // fetch number of nodes available in linked list
    func getListSize() -> Int? {
       
        // Validation check for first node is nil.
        guard firstNode != nil else { return nil }
        
        var tempNode = firstNode
        
        // Maintian a counter to loop
        var noOfNodes = 0
        
        // Traverse till it reaches nil node
        while tempNode != nil {
            
            // If not nil then increment counter
            noOfNodes += 1
            
            // Increment node by pointing to next node
            tempNode = tempNode?.next
        }
        
        return noOfNodes
    }
        
    // Search for item/data existance in list, returns true or false
    func search(anItem item: T?) -> Bool {
        
        guard firstNode != nil else { return false }
        
        var tempNode = self.firstNode
        
        while tempNode != nil {
            
            if tempNode?.data == item {
                // Once item exist return true.
                return true
            }
            
            // Increment node by pointing to next node
            tempNode = tempNode?.next
        }
        
        return false
    }
    
    // Displays content of list
    func showListContent() {
        
        // Visible string to display sequence of data in list
        var visibleNodeSequence: String = ""
        
        var tempNode = self.firstNode
        
        // Travese till reaches end of list
        while tempNode != nil {
            
            if let str = tempNode?.data {
                visibleNodeSequence.append(contentsOf: String(describing:str))
                visibleNodeSequence.append(contentsOf:  tempNode?.next != nil ? " -> " : "")
            }
            
            // Incrementing by pointing to next node
            tempNode = tempNode?.next
        }
        
        print(visibleNodeSequence)
    }
    
}

var ll = SinglyLinkedList<Int>()
ll.add(anItem: 10, from: .left)
ll.add(anItem: 20, from: .right)
ll.add(anItem: 30, from: .left)
ll.add(anItem: 40, from: .left)
ll.add(anItem: 50, from: .right)
ll.add(anItem: 60, from: .right)

ll.getListSize()
ll.showListContent()

print(ll.search(anItem: 40))

print("removed Node: \(String(describing: ll.remove(from: .left)))")
print("removed Node: \(String(describing: ll.remove(from: .right)))")
print("-----")
ll.showListContent()

