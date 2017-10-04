
import Foundation

func performBigOSection()
{
    let result1:[Int] = crossAdd(numbers: [1, 2, 3]);
    print("Result of cross add: \(result1)");
    
    let result2 = find(needle:3, haystack:[1, 2, 3, 4]);
    print("Result of finding needle in haystack: \(result2)");
    
    let result3 = makeTuples(input:[1, 2, 3]);
    print("Result of make tuples: \(result3)");
}

// Reverse the array and add it to itself: [1, 2, 3] returns as [4, 4, 4].
// O(n)
func crossAdd(numbers:[Int]) -> [Int]
{
    var answer = [Int]();
    for i in 0..<numbers.count {
        let goingUp = numbers[i];
        let goingDown = numbers[numbers.count - 1 - i];
        answer.append(goingUp + goingDown);
    }
    return answer;
}

// O(n)
func find(needle:Int, haystack:[Int]) -> Bool
{
    for i in 0..<haystack.count {
        if (haystack[i] == needle) {
            return true;
        }
    }
    return false;
}

// Makes an array of arrays that contains every possible pair of items the argument array.
// O(n^2)
func makeTuples(input:[Int]) -> [[Int]]
{
    var result = [[Int]]();
    for i in 0..<input.count {
        for j in 0..<input.count {
            let tuple:[Int] = [input[i], input[j]];
            result.append(tuple);
        }
    }
    return result;
}

