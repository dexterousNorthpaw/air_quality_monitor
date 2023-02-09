import 'package:air_quality_monitor/models/data_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier {
  DataModel data = DataModel();

  getData() {
    FirebaseDatabase.instance.ref('Values').onValue.listen(
      (DatabaseEvent event) async {
        final placeholder = event.snapshot.value;
        data = placeholder == null
            ? DataModel()
            : DataModel.fromJson(placeholder as Map);
        await Future.delayed(const Duration(milliseconds: 1));
        notifyListeners();
      },
    );
  }
}
