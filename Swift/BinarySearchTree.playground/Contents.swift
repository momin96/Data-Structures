
//  Created by Nasir Ahmed Momin on 12/01/20.
//  Copyright © 2020 Nasir Ahmed Momin. All rights reserved.

// Implementaiton of Binary tree with Generics in Swift
class Node<Element: Comparable> {
    
    // Generic data
    var data: Element
    
    // reference pointer of left tree
    var leftNode: Node?
    
    // reference pointer of right tree
    var rightNode: Node?
    
    private init(_ item: Element) {
        self.data = item
    }
    
    // Create new node by passing data
    static func getNode(item i: Element) -> Node<Element> {
        return Node(i)
    }
    
    // (less than <) Operator overloading for comparing data of two nodes
    static func <(lhs: Node, rhs: Node) -> Bool {
        return lhs.data < rhs.data
    }
    
    // (greater than or equal <) Operator overloading for comparing data of two nodes
    static func >=(lhs: Node, rhs: Node) -> Bool {
        return lhs.data >= rhs.data
    }
    
    func hasLeftChild() -> Bool {
        return self.leftNode != nil
    }
    
    func hasRightChild() -> Bool {
        return self.rightNode != nil
    }
    
    // processing node
    func process() {
        print(self.data, terminator: " -> ")
    }
    
}



struct BinarySearchTree<Element: Comparable> {
    
    // rootNode which holds all its children of left & right side
    var rootNode: Node<Element>?
    
    // Adding item in recursive manner.
    mutating func add(Item item: Element, previousNode: Node<Element>? = nil) {
        
        var newNode: Node<Element>? = Node.getNode(item: item)
        
        // If Root node does not exist, then make newNode as rootNode
        if rootNode == nil {
            rootNode = newNode
        }
        else {
            //
            var processingNode = previousNode
            if processingNode == nil {
                processingNode = rootNode
            }
            
            // data of newNode is greater than or equal of data from node of previous iteration.
            // Navigate to left side of tree
            if newNode! < processingNode! {
                
                // If Node does not exist on left, then make newNode as left node
                if !(processingNode!.hasLeftChild()) {
                    processingNode?.leftNode = newNode
                }
                else {
                    // if Node exist on left side, increment pointer.
                    let next = processingNode?.leftNode
                    
                    // make recurssion call of function repeat process
                    add(Item: item, previousNode: next)
                    
                    // Just to safe gaurd things, I know it is not required.
                    newNode = nil
                }
            }
                // data of newNode is greater than or equal of data from node of previous iteration.
                // Navigate to right side of tree
            else if newNode! >= processingNode! {
                
                // If Node does not exist on right, then make newNode as right node
                if !(processingNode!.hasRightChild()) {
                    processingNode?.rightNode = newNode
                }
                else {
                    
                    // if Node exist on right side, increment pointer.
                    let next = processingNode?.rightNode
                    
                    // make recurssion call of function repeat process
                    add(Item: item, previousNode: next)
                    
                    // Just to safe gaurd things, I know it is not required.
                    newNode = nil
                }
            }
        }
    }
    
    
    // N -> L -> R
    // Process Node, then Visit left node, & visit right node
    private func showPreorderTraversal(_ node: Node<Element>?) {
        
        guard let node = node else { return }
        node.process()
        self.showPreorderTraversal(node.leftNode)
        self.showPreorderTraversal(node.rightNode)
    }
    
    // L -> R -> N
    // Visit left ndoe, visit right node, then Process node
    private func showPostorderTraversal(_ node: Node<Element>?) {
        guard let node = node else { return }
        self.showPostorderTraversal(node.leftNode)
        self.showPostorderTraversal(node.rightNode)
        node.process()
    }
    
    // Visit left node, Process node, then visit right node
    // L -> N -> R
    private func showInorderTraversal(_ node: Node<Element>?) {
        guard let node = node else { return }
        self.showInorderTraversal(node.leftNode)
        node.process()
        self.showInorderTraversal(node.rightNode)
    }
    
    func showTree() {
        print("Preorder traversal")
        showPreorderTraversal(rootNode)
        print("\n")
        
        print("Postorder Traversal")
        showPostorderTraversal(rootNode)
        print("\n")
        
        print("Inorder Traversal")
        showInorderTraversal(rootNode)
    }
    
}

var bst = BinarySearchTree<Int>()
bst.add(Item: 10)
bst.add(Item: 9)
bst.add(Item: 7)
bst.add(Item: 8)
bst.add(Item: 11)
bst.showTree()
