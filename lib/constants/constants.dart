import 'package:firebase_database/firebase_database.dart';

String x = '';
getValue() async {

  DatabaseReference ref = FirebaseDatabase.instance.ref("Values/Air");
  DatabaseEvent event = await ref.once();
  x = event.snapshot.value.toString();
  print(event.snapshot.value);
  print(event.snapshot.value.runtimeType);
}

