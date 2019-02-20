//: # Singly Linked List

public class SinglyLinkedListNode<T: Equatable> {
    public var value: T
    public var next: SinglyLinkedListNode?

    public init(value: T) {
        self.value = value
    }
}

public struct SinglyLinkedList<T: Equatable> {
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
            for _ in 1 ..< index {
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

    public func remove(at index: Int) -> T {
        precondition(index >= 0 && index < self.count)

        let previous = self.node(atIndex: index - 1)
        let nodeToDelete = self.node(atIndex: index)

        previous.next = nodeToDelete.next

        return nodeToDelete.value
    }

    public func remove(with node: Node?) {
        var previous = head

        while previous?.value != node?.value {
            guard let next = head?.next else {
                return
            }
            previous = next
        }

        previous?.next = node?.next
    }
}

extension SinglyLinkedList {
    public mutating func reverse() {
        var current = head
        var prev: Node? = nil
        var next: Node? = nil

        while current != nil {
            next = current?.next
            current?.next = prev
            prev = current
            current = next
        }
        head = prev
    }
}

extension SinglyLinkedList: CustomStringConvertible {
    public var description: String {
        var s = "["
        var node = head
        while node != nil {
            s += "\(node!.value)"
            node = node?.next
            if node != nil { s += ", "}
        }
        return s + "]"
    }
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
list.insert(node, atIndex: 2)
list[0]
list[1]
list[2]

list.reverse()

list.remove(at: 1)
list.description

let node1 = SinglyLinkedListNode(value: "1")
list.remove(with: node1)
list.description
