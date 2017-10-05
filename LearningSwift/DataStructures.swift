/*
 
 SET
     An amorphous blob of unordered unique items. No dupes!
     Add/Remove/Check if it has a thing/Get a list of the stuff in it.
 
 MAP
     Key/value paired items. Keys are a Set collection (no dupes!).
     Keys must be unique, but multiple keys can map to the same value.
     No ordering to the keys... because they're a Set.

 STACK
     Last In, First Out / First In, Last Out
     Push/Pop/Peek
     You use stacks all the time because you program on a stack.
 
 QUEUE
     First in, first out. Like waiting in a line.
     Enqueue/Dequeue/Peek
 
 ARRAYLIST
     An array with the behavior of a List.
     It takes up contiguous memory that you directly manage.
     Cheap Get, expensive Delete.
 
 LINKED LIST
     Cheap Add/Remove, expensive Get. Inverse of the ArrayList.
     To Get, it has to traverse every linked node till it finds the thing.
     To Add, it links another node (nodes can be wherever in memory).
     Deletes are cheap because all that is is changing what a pointer points to.
 
 */

import Foundation

func performDataStructuresSection()
{
//    var mySet:Set = Set();
//    var myMap:Map = Map();
//    var myStack:Stack = Stack();
//    var myQueue:Queue = Queue();
    
//    let myArrayList:ArrayList = ArrayList();
//    print("ArrayList length: \(myArrayList.length)");
//    for i in 0..<100 {
//        myArrayList.push(i);
//        print("ArrayList length: \(myArrayList.length)");
//    }
//    print(myArrayList.getItems());
//    myArrayList.delete(index:2);
//    print(myArrayList.getItems());
//    myArrayList.delete(index:3);
//    print(myArrayList.getItems());
    
    let myLL = LinkedList();
    myLL.push(11);
    myLL.push(22);
    myLL.push(33);
    print(myLL.get(index:0));
    print(myLL.get(index:1));
    print(myLL.get(index:2));
//    print(myLL.popTail()!);
//    print(myLL.popTail()!);
//    print(myLL.popTail()!);
    myLL.delete(index:0);
    print(myLL.get(index:0));
    print(myLL.get(index:1));
}

class Set
{
    var items:[Int] = [];
    
    func add(_ item:Int) {
        if (items.contains(item)) {
            return;
        } else {
            items.append(item);
        }
    }
    
    func remove(_ item:Int) {
        for i in 0..<items.count - 1 {
            if (items[i] == item) {
                items.remove(at:i);
            }
        }
    }
    
    func contains(_ item:Int) -> Bool {
        for i in items {
            if (i == item) {
                return true;
            }
        }
        return false;
    }
    
    func toList() -> [Int] {
        return items;
    }
}

class Map
{
    var keys:Set = Set();
    var values:[Any] = [];
    
    func addKeyValuePair(key:Int, value:Any) {
        keys.add(key);
        values.append(value);
    }
}

class Stack
{
    var items:[Int] = [];
    
    func push(item:Int) {
        items.append(item);
    }
    
    func pop() -> Int? {
        if (items.count > 0) {
            return items.removeLast();
        } else {
            return nil;
        }
    }
    
    func peek() -> Int? {
        if (items.count > 0) {
            return items.last!;
        } else {
            return nil;
        }
    }
}

class Queue
{
    var items:[Int] = [];
    
    func enqueue(item:Int) {
        items.append(item);
    }
    
    func dequeue() -> Int? {
        if (items.count > 0) {
            return items.removeFirst();
        } else {
            return nil;
        }
    }
    
    func peek() -> Int? {
        return items.first;
    }
}

class ArrayList
{
    // Swift doesn't support fix-lengthed arrays, so...
    var items:[Int?] = [Int?](repeating:nil, count: 100);
    
    // Manually manage array length since we can't declare array size.
    // This makes the implementation silly, but it's for me to learn Swift, so deal.
    var length:Int = 0;
    
    func getLength() -> Int {
        return length;
    }
    
    func push(_ item:Int) {
        if (length < 100) {
            // Length starts at 0 so index with it before incrementing it:
            items[length] = item;
            length += 1;
        }
    }
    
    func pop() -> Int? {
        if (length > 0) {
            // Decrement length before indexing with it:
            length -= 1;
            let popped:Int = items[length]!;
            items[length] = nil;
            return popped;
        } else {
            return nil;
        }
    }
    
    func get(index:Int) -> Int? {
        if (index < 100) {
            return items[index];
        } else {
            fatalError("Out of bounds of our silly array list!");
        }
    }
    
    func getItems() -> [Int?] {
        return items;
    }
    
    func delete(index:Int) {
        if (index < 100) {
            if (items[index] != nil) {
                // Don't bother deleting the index, collapse into it:
                collapse(fromIndex:index);
                length -= 1;
            }
        } else {
            fatalError("Out of bounds of our silly array list!");
        }
    }
    
    private func collapse(fromIndex:Int) {
        for i in fromIndex..<items.count - 1 {
            // Shift stuff until we run out of stuff:
            if (items[i + 1] != nil) {
                items[i] = items[i + 1];
                // Make the space after the last shifted item nil:
                if (i + 1 == length - 1) {
                    items[length - 1] = nil;
                }
            } else {
                break;
            }
        }
    }
}

class Node
{
    var payload:Int = 0;
    var next:Node? = nil;
    var previous:Node? = nil;
    
    init(_ value:Int) {
        payload = value;
    }
}

class LinkedList
{
    var head:Node? = nil;
    var tail:Node? = nil;
    var length:Int = 0;
    
    func push(_ value:Int) {
        length += 1;
        let newNode = Node(value);
        if (nil == head) {
            head = newNode;
        } else {
            tail!.next = newNode;
            newNode.previous = tail!;
        }
        tail = newNode;
    }
    
    func popTail() -> Int? {
        if (nil == head) {
            return nil;
        }
        if (length == 1) {
            let payload = head!.payload;
            head = nil;
            tail = nil;
            length -= 1;
            return payload;
        }
        let payload = tail!.payload;
        tail = tail!.previous!;
        length -= 1;
        return payload;
    }
    
    func get(index:Int) -> Int {
        if (length == 0 || index >= length) {
            fatalError("Our silly linked list doesn't contain that much stuff!");
        }
        var currentNode:Node = head!;
        for _ in 0..<index {
            currentNode = currentNode.next!;
        }
        return currentNode.payload;
    }
    
    func delete(index:Int) {
        if (length == 0 || index >= length) {
            fatalError("Our silly linked list doesn't contain that much stuff!");
        }
        if (index == 0) {               // Delete head?
            head = head!.next!;
        } else if (index == length) {   // Delete tail?
            tail!.previous!.next = nil;
        } else {                        // Delete something in the middle?
            var nodeToDelete:Node = head!;
            for _ in 0..<index {
                nodeToDelete = nodeToDelete.next!;
            }
            nodeToDelete.previous!.next! = nodeToDelete.next!;
        }
    }
}
