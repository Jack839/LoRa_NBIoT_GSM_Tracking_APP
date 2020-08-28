import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:lora_gpstracking2/models/courseSection.dart';
import 'package:lora_gpstracking2/models/record..dart';

class FoodNotifier with ChangeNotifier {
 // Record _foodList;
  List<Mapping> _locationList;
  Mapping _currentSelectedDevice;

  //UnmodifiableListView<Record> get foodList => UnmodifiableListView(_foodList);
  //Record get foodList => _foodList;
  List<Mapping> get locationList => _locationList;
  Mapping get currentSelectedDevice => _currentSelectedDevice;

  set locationList( foodList) {
    _locationList = foodList;
    notifyListeners();
  }

  set currentSelectedDevice(Mapping food) {
    _currentSelectedDevice = food;
    notifyListeners();
  }

//  addFood(Record food) {
//    _foodList.insert(0, food);
//    notifyListeners();
//  }

//  deleteFood(Record food) {
//    _foodList.removeWhere((_food) => _food.id == food.id);
//    notifyListeners();
//  }
}