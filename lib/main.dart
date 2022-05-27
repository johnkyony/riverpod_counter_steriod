import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'counter/controller.dart';

void main() {
  runApp( const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const CounterIndexPage(),
    );
  }
}

class CounterIndexPage extends HookConsumerWidget {
  const CounterIndexPage({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context , ref) {




    return Scaffold(
      appBar: AppBar(
        title: const Text('My counter app'),
      ),
      body: Column(
        children: const [
          NewCounterButton(),
          Expanded(child: CounterListView())
        ],

      )
    );
  }
}

class NewCounterButton extends HookConsumerWidget {
  const NewCounterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context , ref) {

    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [

          IconButton(
            onPressed: (){
              ref.read(counterControllerProvider.notifier).add();
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(
              onPressed: (){
                ref.read(counterControllerProvider.notifier).saveState();
              }, icon: const Icon(Icons.add_circle)),
        ],
      ),

    );
  }
}

class CounterListView extends HookConsumerWidget {
  const CounterListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context , ref) {
    final counters = ref.watch(counterControllerProvider);
    return ListView.builder(
        itemCount: counters.length,
        itemBuilder: (context , index){
          final counter = counters[index];
          return ListTile(
            leading: IconButton(
              onPressed: (){
                  ref.read(counterControllerProvider.notifier).delete(index);
              },
              icon: const Icon(Icons.delete),
            ),
            title: Text("${counter.value}"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(onPressed: (

                    ){
                  ref.read(counterControllerProvider.notifier).increment(index);
                }, icon: const Icon(Icons.add)),
                IconButton(onPressed: (){
                  ref.read(counterControllerProvider.notifier).decrement(index);
                }, icon: const Icon(Icons.remove))
              ],
            ),

          );
        });
  }
}

