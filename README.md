# Quick Sort Recursive Function

A program that performs a quick sort algorithm recursively.

## ⚙️ Technologies

-   MIPS Assembly Language

## ⚡ Features

-   Asks the user to enter n and allocates the array dynamically
-   Asks the user to input n elements of type int
-   The user input is stored in an array[]
-   Returns the address of the array[] in $v0 and returns n in $v1
-   Displays the n elements of array[]

## 📝 C code

The following functions (written in C language) describe the program:

```
void quick_sort(int array[], int n) {
    int i = 0; // i = low index
    int j = n-1; // j = high index
    int pivot = array[(i+j)/2]; // pivot = middle value
    while (i <= j) {
        while (array[i] < pivot) i++;
            while (array[j] > pivot) j--;
            if (i <= j) {
            int temp = array[i];
            array[i] = array[j]; // swap array[i]
            array[j] = temp; // with array[j]
            i++;
            j--;
        }
    }
    if (j > 0) quick_sort(&array[0], j+1); // Recursive call 1
    if (i < n-1) quick_sort(&array[i], n-i); // Recursive call 2
}

(int array[], int n) read_array () {
    // Ask the user to enter n and allocate the array dynamically
    // Ask the user to input n elements of type int
    // The user input should be stored in array[]
    // Return the address of the array[] in $v0 and return n in $v1
}
void print_array (int array[], int n) {
    // Display the n elements of array[]
}

```

## ✒️ Author

| [<img src="https://github.com/M-Alhassan.png?size=115" width="115"><br><sub>@M-Alhassan</sub>](https://github.com/M-Alhassan) |
| :---------------------------------------------------------------------------------------------------------------------------: |
