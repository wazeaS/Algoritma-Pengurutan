void insertionSort<T extends Comparable<T>>(List<T> arr) {
  for (int i = arr.length - 1; i >= 0; i--) {
    for (int j = i + 1, k = i; j < arr.length; j++) {
      if (arr[j].compareTo(arr[k]) > 0) {
        break;
      } else {
        T temp = arr[k];
        arr[k] = arr[j];
        arr[j] = temp;
        k = j;
      }
    }
  }
}

void bubbleSortDescending<T extends Comparable<T>>(List<T> arr) {
  int n = arr.length;
  for (int i = 0; i < n - 1; i++) {
    for (int j = 0; j < n - i - 1; j++) {
      if (arr[j].compareTo(arr[j + 1]) < 0) {
        T temp = arr[j];
        arr[j] = arr[j + 1];
        arr[j + 1] = temp;
      }
    }
  }
}

void display<T>(List<T> data) {
  for (T obj in data) {
    print('$obj ');
  }
  print('');
}

void main() {
  List<num> data = List<num>.generate(10, (index) => (index + 1) * 2);
  data.shuffle();
  
  print('Data Sebelum Pengurutan:');
  display(data);
 
  DateTime start = DateTime.now();
  insertionSort<num>(data);
  Duration elapsedTime = DateTime.now().difference(start);
  print('Data Setelah Pengurutan (Insertion Sort - Ascending):');
  display(data);
  print('Waktu: $elapsedTime');

  data.shuffle(); 
  print('\nData Sebelum Pengurutan Bubble Sort Descending:');
  display(data);

  start = DateTime.now();
  bubbleSortDescending<num>(data);
  elapsedTime = DateTime.now().difference(start);
  print('Data Setelah Pengurutan (Bubble Sort - Descending):');
  display(data);
  print('Waktu: $elapsedTime');
}
