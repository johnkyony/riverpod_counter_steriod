import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'model.dart';


final counterControllerProvider = StateNotifierProvider<CounterController , List<Counter>>((ref) => CounterController(),);

class CounterController extends StateNotifier< List<Counter>>{
  CounterController(): super([]);

  void add (){
    state = [Counter(value: 0) , ...state];
  }

  void delete(int index){
      if(index < 0 || index >= state.length){
        return;
      }
      final target = state[index];
      state.remove(target);
      state = [...state];
  }

  void increment(int index){
      final counter = state[index];
      state[index] = counter.increment();
      state = [...state];

  }

  void decrement(int index){
    final counter = state[index];
    state[index] = counter.decrement();
    state = [...state];
  }


}