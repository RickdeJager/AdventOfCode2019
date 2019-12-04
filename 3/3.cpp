#include <iostream>
#include <fstream>
#include <list>
#include <array>
#include <string>
#include <map>
#include <fstream>
#include <sstream>

using namespace std;

int read_wire_strings(list<string>* wire1, list<string>* wire2) {
	ifstream file("input.txt");
	string line;
	// Read the first line into memory
	getline(file, line);
	stringstream linestream(line);
	string value;
	// Add direction codes to the wire
	// Not great for runtime but it works
	while(getline(linestream, value, ',')) {
		wire1->push_back(value);
	}
	getline(file, line);
	stringstream linestream2(line);
	while(getline(linestream2, value, ',')) {
		wire2->push_back(value);
	}
	return 0;
}

int lay_wire(map<string, tuple<char, int>>* grid, list<string>* wire, char symbol, list<array<int, 4>>* overlaps) {
	int ix = 0;
	int iy = 0;
	int wire_step = 0;
	// For direction code in wire
	for (string w : *wire) {
		int dx = 0;
		int dy = 0;
		switch(w.front()) {
			case 'L': dx = -1;
				  break;
			case 'R': dx = 1;
				  break;
			case 'U': dy = -1;
				  break;
			case 'D': dy = 1;
				  break;
		}
		int amount = stoi(w.substr(1));
		for (int i = 0; i < amount; i++) {
			ix = ix + dx;
			iy = iy + dy;
			wire_step++;
			// No intersection at origin
			if (ix == 0 and iy == 0) continue;
			// Create keys as "x|y"
			stringstream stream;
			stream << ix << "|" << iy;
			string key = stream.str();
			auto elem = grid->find(key);
			// If no wire here yet...
			if (elem == grid->end()) {
				tuple<char, int> value = {symbol, wire_step};
				grid->insert({key, value});
			// If there is a wire, check if its the other one.
			} else {
				char cur_symbol = get<0>(elem->second);
				int cur_steps = get<1>(elem->second);
				if (symbol == cur_symbol) continue;
				array<int, 4> overlap = {ix, iy, wire_step, cur_steps};
				overlaps->push_front(overlap);
			}
		}
	}
	return 0;

}

int print_closest_overlap(list<array<int, 4>>* overlaps) {
	int d = 9999999;
	for (const auto& overlap : *overlaps) {
		int this_d = abs(overlap[0]) + abs(overlap[1]);
		if (this_d < d) {
			d = this_d;
		}
	}
	cout << "closest overlap: ";
	cout << d;
	cout << "\n";
	return 0;
}

int print_earliest_overlap(list<array<int, 4>>* overlaps) {
	int d = 9999999;
	for (const auto& overlap : *overlaps) {
		int this_d = overlap[2] +overlap[3];
		if (this_d < d) {
			d = this_d;
		}
	}
	cout << "earliest overlap: ";
	cout << d;
	cout << "\n";
	return 0;
}

int main () {
	// Define wires as lists of strings
	// ["R1", "U2", ... ]
	list<string> wire1;
	list<string> wire2;
	//x, y, steps_orig, steps_at_overlap
	list<array<int, 4>> overlaps;
	//map with coords as key, and symbol + steps as value
	map<string, tuple<char, int>> grid;
	read_wire_strings(&wire1, &wire2);
	lay_wire(&grid, &wire1, '1', &overlaps);
	lay_wire(&grid, &wire2, '2', &overlaps);
	print_closest_overlap(&overlaps);
	print_earliest_overlap(&overlaps);
	return 0;
}
