import 'dart:io';
import 'dart:math';

void main() {
  List<int> data = List.generate(100, (_) => Random().nextInt(100));
  print("Data sebelum pengurutan:");
  printData(data);

  // Menu pilihan algoritma sorting
  print("\nALGORITMA SORTING");
  print("1. Insertion\n2. Selection\n3. Bubble\n4. Shell\n5. Quick\n6. Merge");
  stdout.write("Pilihan: ");
  int choice = int.parse(stdin.readLineSync()!);
  
  print("1. Ascending\n2. Descending");
  stdout.write("Pilihan: ");
  bool ascending = stdin.readLineSync()! == '1';
  
  DateTime start = DateTime.now();
  switch (choice) {
    case 1:
      insertionSort(data, ascending);
      break;
    case 2:
      selectionSort(data, ascending);
      break;
    case 3:
      bubbleSort(data, ascending);
      break;
    case 4:
      shellSort(data, ascending);
      break;
    case 5:
      quickSort(data, 0, data.length - 1, ascending);
      break;
    case 6:
      mergeSort(data, 0, data.length - 1, ascending);
      break;
    default:
      print("Pilihan tidak valid");
      return;
  }
  Duration elapsedTime = DateTime.now().difference(start);

  print("\nData setelah pengurutan:");
  printData(data);
  print("Waktu: ${elapsedTime.inMilliseconds} ms");
}

void insertionSort(List<int> arr, bool ascending) {
  for (int i = 1; i < arr.length; i++) {
    int key = arr[i];
    int j = i - 1;
    while (j >= 0 && (ascending ? arr[j] > key : arr[j] < key)) {
      arr[j + 1] = arr[j];
      j--;
    }
    arr[j + 1] = key;
  }
}

void selectionSort(List<int> arr, bool ascending) {
  for (int i = 0; i < arr.length - 1; i++) {
    int minMax = i;
    for (int j = i + 1; j < arr.length; j++) {
      if (ascending ? arr[j] < arr[minMax] : arr[j] > arr[minMax]) {
        minMax = j;
      }
    }
    int temp = arr[i];
    arr[i] = arr[minMax];
    arr[minMax] = temp;
  }
}

void bubbleSort(List<int> arr, bool ascending) {
  for (int i = 0; i < arr.length - 1; i++) {
    for (int j = 0; j < arr.length - i - 1; j++) {
      if (ascending ? arr[j] > arr[j + 1] : arr[j] < arr[j + 1]) {
        int temp = arr[j];
        arr[j] = arr[j + 1];
        arr[j + 1] = temp;
      }
    }
  }
}

void shellSort(List<int> arr, bool ascending) {
  for (int gap = arr.length ~/ 2; gap > 0; gap ~/= 2) {
    for (int i = gap; i < arr.length; i++) {
      int temp = arr[i];
      int j;
      for (j = i; j >= gap && (ascending ? arr[j - gap] > temp : arr[j - gap] < temp); j -= gap) {
        arr[j] = arr[j - gap];
      }
      arr[j] = temp;
    }
  }
}

void quickSort(List<int> arr, int low, int high, bool ascending) {
  if (low < high) {
    int pivot = partition(arr, low, high, ascending);
    quickSort(arr, low, pivot - 1, ascending);
    quickSort(arr, pivot + 1, high, ascending);
  }
}

int partition(List<int> arr, int low, int high, bool ascending) {
  int pivot = arr[high];
  int i = low - 1;
  for (int j = low; j < high; j++) {
    if (ascending ? arr[j] <= pivot : arr[j] >= pivot) {
      i++;
      int temp = arr[i];
      arr[i] = arr[j];
      arr[j] = temp;
    }
  }
  int temp = arr[i + 1];
  arr[i + 1] = arr[high];
  arr[high] = temp;
  return i + 1;
}

void mergeSort(List<int> arr, int left, int right, bool ascending) {
  if (left < right) {
    int mid = (left + right) ~/ 2;
    mergeSort(arr, left, mid, ascending);
    mergeSort(arr, mid + 1, right, ascending);
    merge(arr, left, mid, right, ascending);
  }
}

void merge(List<int> arr, int left, int mid, int right, bool ascending) {
  List<int> temp = arr.sublist(left, right + 1);
  int i = left, j = mid + 1, k = left;
  while (i <= mid && j <= right) {
    if (ascending ? temp[i - left] <= temp[j - left] : temp[i - left] >= temp[j - left]) {
      arr[k++] = temp[i++ - left];
    } else {
      arr[k++] = temp[j++ - left];
    }
  }
  while (i <= mid) arr[k++] = temp[i++ - left];
  while (j <= right) arr[k++] = temp[j++ - left];
}

void printData(List<int> data) {
  print(data.join(", "));
}
