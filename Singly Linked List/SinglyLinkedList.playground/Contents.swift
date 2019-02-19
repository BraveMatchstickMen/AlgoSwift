//: # Singly Linked List

public class SinglyLinkedListNode<T> {
    public var value: T
    public var next: SinglyLinkedListNode?

    public init(value: T) {
        self.value = value
    }
}

public struct SinglyLinkedList<T> {
    public typealias Node = SinglyLinkedListNode<T>
    private var head: Node?

    public var isEmpty: Bool {
        return head == nil
    }

    public var first: Node? {
        return head
    }

    public var last: Node? {
        guard var node = head else {
            return nil
        }

        while let next = node.next {
            node = next
        }

        return node
    }

    public mutating func append(value: T) {
        let newNode = Node(value: value)
        if let lastNode = last {
            lastNode.next = newNode
        } else {
            head = newNode
        }
    }

    public var count: Int {
        guard var node = head else {
            return 0
        }

        var count = 1
        while let next = node.next {
            node = next
            count += 1
        }
        return count
    }

    public func node(atIndex index: Int) -> Node {
        if index == 0 {
            return head!
        } else {
            var node = head?.next
            for _ in 1..<index {
                node = node?.next
                if node == nil {
                    break
                }
            }
            return node!
        }
    }

    public subscript(index: Int) -> T {
        let node = self.node(atIndex: index)
        return node.value
    }

    public mutating func insert(_ node: Node, atIndex index: Int) {
        let newNode = node
        if index == 0 {
            head = newNode
        } else {
            let prev = self.node(atIndex: index - 1)
            let next = prev.next
            newNode.next = next
            prev.next = newNode
        }
    }

    public mutating func removeAll() {
        head = nil
    }

//    public func remove(node: Node) -> T {
//        
//    }
}

var list = SinglyLinkedList<String>()
list.isEmpty
list.first

list.append(value: "1")
list.isEmpty
list.first?.value
list.last?.value

list.append(value: "2")
list.first?.value
list.last?.value

list.count

list.node(atIndex: 0).value
list.node(atIndex: 1).value
list[0]
list[1]

let node = SinglyLinkedListNode(value: "3")
list.insert(node, atIndex: 1)
list[0]
list[1]
list[2]
