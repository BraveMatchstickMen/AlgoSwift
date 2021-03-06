//: Binary Search Tree (BST)

public class BinarySearchTree<T: Comparable> {
    private(set) public var value: T
    private(set) public var parent: BinarySearchTree?
    private(set) public var left: BinarySearchTree?
    private(set) public var right: BinarySearchTree?

    public init(value: T) {
        self.value = value
    }

    public convenience init(array: [T]) {
        precondition(array.count > 0)
        self.init(value: array.first!)
        for v in array.dropFirst() {
            insert(value: v)
        }
    }

    public var isRoot: Bool {
        return parent == nil
    }

    public var isLeftChild: Bool {
        return parent?.left === self
    }

    public var isLeaf: Bool {
        return left == nil && right == nil
    }

    public func minimum() -> BinarySearchTree {
        var node = self
        while let next = node.left {
            node = next
        }
        return node
    }

    public func maximum() -> BinarySearchTree {
        var node = self
        while let next = node.right {
            node = next
        }
        return node
    }
}

extension BinarySearchTree {
    public func insert(value: T) {
        if value < self.value {
            if let left = left {
                left.insert(value: value)
            } else {
                left = BinarySearchTree(value: value)
                left?.parent = self
            }
        } else {
            if let right = right {
                right.insert(value: value)
            } else {
                right = BinarySearchTree(value: value)
                right?.parent = self
            }
        }
    }

    public func search(value: T) -> BinarySearchTree? {
        if value < self.value {
            return left?.search(value: value)
        } else if value > self.value {
            return right?.search(value: value)
        } else {
            return self
        }
    }

    public func map(formula: (T) -> T) -> [T] {
        var a = [T]()
        if let left = left { a += left.map(formula: formula)}
        a.append(formula(value))
        if let right = right { a += right.map(formula: formula)}

        return a
    }

    // filter
    // reduce

    public func toArray() -> [T] {
        return map { $0 }
    }
}

extension BinarySearchTree {
    @discardableResult public func remove() -> BinarySearchTree? {
        let replacement: BinarySearchTree?

        if let right = right {
            replacement = right.minimum()
        } else if let left = left {
            replacement = left.maximum()
        } else {
            replacement = nil
        }

        replacement?.remove()

        replacement?.right = right
        replacement?.left = left
        right?.parent = replacement
        left?.parent = replacement
        reconnectParentTo(node: replacement)

        parent = nil
        left = nil
        right = nil

        return replacement
    }
}

extension BinarySearchTree {
    private func reconnectParentTo(node: BinarySearchTree?) {
        if let parent = parent {
            if isLeftChild {
                parent.left = node
            } else {
                parent.right = node
            }
        }
        node?.parent = parent
    }
}

extension BinarySearchTree {
    public func height() -> Int {
        if isLeaf {
            return 0
        } else {
            return 1 + max(left?.height() ?? 0, right?.height() ?? 0)
        }
    }

    public func depth() -> Int {
        var node = self
        var edges = 0
        while let parent = node.parent {
            node = parent
            edges += 1
        }
        return edges
    }
}

extension BinarySearchTree: CustomStringConvertible {
    public var description: String {
        var s = ""
        if let left = left {
            s += "(\(left.description)) <- "
        }
        s += "\(value)"
        if let right = right {
            s += " -> (\(right.description))"
        }
        return s
    }
}

let tree = BinarySearchTree<Int>(value: 7)
tree.insert(value: 2)
tree.insert(value: 5)
tree.insert(value: 10)
tree.insert(value: 9)
tree.insert(value: 1)

print(tree)

let treeArray = BinarySearchTree<Int>(array: [7, 2, 5, 10, 9, 1])

print(tree)

tree.search(value: 2)
tree.search(value: 6)

tree.toArray()
tree.height()
tree.search(value: 2)?.remove()

print(tree)

tree.search(value: 9)?.depth()
