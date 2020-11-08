#include <iostream>
#include <string>
#include <vector>
using namespace std;
void quickSort(int* arr, int left, int right) {
	int i = left, j = right;
	int tmp;
	int pivot = arr[(left + right) / 2];
	if (pivot % 2 == 0) {
		while (i <= j) {
			while (arr[i] % 2 == 0 and arr[i] < pivot)
				i++;
			while (arr[j] % 2 != 0 or (arr[j] % 2 == 0 and arr[j] > pivot))
				j--;
			if (i <= j) {
				tmp = arr[i];
				arr[i] = arr[j];
				arr[j] = tmp;
				i++;
				j--;
			}
		}
	}
	else if (pivot % 2 != 0) {
		while (i <= j) {
			while (arr[i] % 2 == 0 or (arr[i] % 2 != 0 and arr[i] > pivot))
				i++;
			while (arr[j] % 2 != 0 and arr[j] < pivot)
				j--;
			if (i <= j) {
				tmp = arr[i];
				arr[i] = arr[j];
				arr[j] = tmp;
				i++;
				j--;
			}
		}
	}
	if (left < j)
		quickSort(arr, left, j);
	if (i < right)
		quickSort(arr, i, right);
}

int main() {
	//система ввода строки чисел единоразовым вводом с любым количеством пробелов
	//возможен ввод большего количества чисел, чем заданное n, но запишутся только первые n чисел
	setlocale(LC_ALL, "rus");
	int n, data = 0;
	vector<int> array; 
	cout << "Введите n: "; cin >> n;
	cout << "\nВведите строку чисел через пробелы: " << endl;
	while (cin >> data) {
		array.emplace_back(data);
		if (array.size() == n)
			break;
	}
	int* arr = new int[n];
	for (int i = 0; i < array.size(); i++) { 
		arr[i] = array[i]; 
	}
	cout << "Input: " << endl;
	for (int i = 0; i < n; i++) {
		cout << arr[i];
		cout << " ";
	}
	array.clear(); array.shrink_to_fit();
	quickSort(arr, 0, n - 1);
	cout << "\nOutput: " << endl;
	for (int i = 0; i < n; i++) {
		cout << arr[i];
		cout << " ";
	}
	delete[] arr;
	return 0;
}