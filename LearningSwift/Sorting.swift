
import Foundation

func performSortingSection()
{
    print(bubbleSort(array:[10,5,3,8,2,6,4,7,9,1]));
    print(insertionSort(array:[10,5,3,8,2,6,4,7,9,1]));
    print(stitch(sortedArray1: [1, 3, 5, 7, 9, 10], sortedArray2: [2, 4, 6]));
    print(mergeSort(numbers: [10,5,3,8,2,6,4,7,9,1]));
    print("Median: \(findMedianOf2SortedArrays(numbers1: [1, 5, 8, 9], numbers2: [2, 3, 7, 10]))");
    print(quickSort([10, 1, 9, 2, 8, 3, 112, 7, 787, 1, 4]));
}

func swap(array:inout [Int], i:Int, j:Int)
{
    let temp = array[i];
    array[i] = array[j];
    array[j] = temp;
}

func bubbleSort(array:[Int]) -> [Int]
{
    print("Bubble Sort!");
    var numbers = array;
    var swapped = false;
    repeat {
        swapped = false;
        for i in 0..<numbers.count - 1 {
            if (numbers[i] > numbers[i+1]) {
                swap(array: &numbers, i: i, j: i+1);
                swapped = true;
                print(numbers);
            }
        }
    } while(swapped);
    return numbers;
}

func insertionSort(array:[Int]) -> [Int]
{
    print("Insertion Sort!");
    var numbers = array;
    for i in 1..<numbers.count {
        for j in 0..<i {
            print(numbers);
            if (numbers[i] < numbers[j]) {
                numbers.insert(numbers.remove(at:i), at:j);
            }
        }
    }
    return numbers;
}

func stitch(sortedArray1:[Int], sortedArray2:[Int]) -> [Int]
{
    print("Stitching \(sortedArray1) to \(sortedArray2)");
    var result:[Int] = [];
    var i:Int = 0;
    var j:Int = 0;
    
    while (i < sortedArray1.count && j < sortedArray2.count) {
        if (sortedArray1[i] < sortedArray2[j]) {
            result.append(sortedArray1[i]);
            i = i + 1;
        } else {
            result.append(sortedArray2[j]);
            j = j + 1;
        }
    }
    
    if (i == sortedArray1.count) {
        // Array1 ran out first. Add the rest of Array2 to result:
        result.append(contentsOf: sortedArray2[j..<sortedArray2.count]);
    } else {
        // Array2 ran out first. Add the rest of Array1 to result:
        result.append(contentsOf: sortedArray1[i..<sortedArray1.count]);
    }
    return result;
}

// Break down a list into lists of one, then stitch them as the call stack unwinds.
// O(n log n) (divide-and-conquor algorithms are logarithmic):
func mergeSort(numbers:[Int]) -> [Int]
{
    print("Merge Sort!");
    if (numbers.count < 2) {
        return numbers;
    }
    let middle:Int = numbers.count / 2;
    var leftHalf:[Int] = Array(numbers[0..<middle]);
    var rightHalf:[Int] = Array(numbers[middle..<numbers.count]);
    
    leftHalf = mergeSort(numbers:leftHalf);
    rightHalf = mergeSort(numbers:rightHalf);
    let stitched = stitch(sortedArray1: leftHalf, sortedArray2: rightHalf);
    
    return stitched;
}

func findMedianOf2SortedArrays(numbers1:[Int], numbers2:[Int]) -> Int
{
    print("Find median of two sorted arrays!");
    let stitched:[Int] = stitch(sortedArray1: numbers1, sortedArray2: numbers2);
    let middle:Int = stitched.count / 2;
    return stitched[middle];
}

func findMedianMoreEfficientlyByApplyingPreviouslyFiguredOutAlgorithm(numbers1:[Int], numbers2:[Int]) -> Int
{
    print("Find the median more efficiently by applying previously figured out algorithm!");
    var median:Int = 0;
    let middle:Int = (numbers1.count + numbers2.count) / 2;
    var count:Int = 1;  // Keep this in step with # of elements, not 0 index.
    var left_idx:Int = 0;
    var right_idx:Int = 0;
    
    while (left_idx < numbers1.count && right_idx < numbers2.count) {
        if (numbers1[left_idx] < numbers2[right_idx]) {
            left_idx += 1;
            count += 1;
            if (count == middle) {
                median = numbers1[left_idx];
                break;
            }
        } else {
            right_idx += 1;
            count += 1;
            if (count == middle) {
                median = numbers2[right_idx];
                break;
            }
        }
    }
    let remainingSteps:Int = middle - count;
    
    if (left_idx == numbers1.count) {
        right_idx += remainingSteps;
        median = numbers2[right_idx];
    } else if (right_idx == numbers2.count) {
        left_idx += remainingSteps;
        median = numbers1[left_idx];
    }
    return median;
}

// Pivot on the right, put < in one array and > in another, and recurse.
// O(n log n)
func quickSort(_ numbers:[Int]) -> [Int]
{
    print("Quick Sort!");
    if (numbers.count < 2) {
        return numbers;
    }
    var lesserNumbers:[Int] = [];
    var greaterNumbers:[Int] = [];
    let pivot:Int = numbers.last!;
    
    for i in 0..<numbers.count - 1 {
        if (numbers[i] < pivot) {
            lesserNumbers.append(numbers[i]);
        } else {
            greaterNumbers.append(numbers[i]);
        }
    }
    
    // The _ in param list allows omitting param name:
    lesserNumbers = quickSort(lesserNumbers);
    greaterNumbers = quickSort(greaterNumbers);
    
    var result:[Int] = [];
    
    for i in 0..<lesserNumbers.count {
        result.append(lesserNumbers[i]);
    }
    result.append(pivot);
    
    for i in 0..<greaterNumbers.count {
        result.append(greaterNumbers[i]);
    }
    
    return result;
}

