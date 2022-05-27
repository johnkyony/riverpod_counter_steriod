import 'dart:developer';
import 'package:uuid/uuid.dart';
class Counter {
   late final String id ;
  final int value ;

   Counter({  String? id, required this.value}) {
    id = id ?? const Uuid().v1();
  }

  Counter increment(){
    return Counter( value: value + 1);
  }

  Counter decrement(){
    return Counter(  value: value - 1);
  }
}