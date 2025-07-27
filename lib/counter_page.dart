import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// state provider
final counter = StateProvider<int>((ref) {
  return 0;
});

final switchProvider = StateProvider<bool>((ref) {
  return false;
});

// it use with statefull widget
class CounterPage extends ConsumerStatefulWidget {
  const CounterPage({super.key});

  @override
  ConsumerState<CounterPage> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends ConsumerState<CounterPage> {
  @override
  void initState() {
    super.initState();
    // Wrap the update inside WidgetsBinding.instance.addPostFrameCallback, which runs after the build phase:
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(switchProvider.notifier).state = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('widget build');

    return Scaffold(
      appBar: AppBar(title: Text('Counter App')),
      body: Column(
        children: [
          Consumer(
            builder: (context, ref, child) {
              final count = ref.watch(counter);
              print('count');
              return Center(
                child: Text(count.toString(), style: TextStyle(fontSize: 50)),
              );
            },
          ),

          Consumer(
            builder: (context, ref, child) {
              final count = ref.watch(switchProvider);
              print('Switch');
              return Switch(
                value: count,
                onChanged: (value) {
                  print('onChange Switch');
                  ref.read(switchProvider.notifier).state = value;
                },
              );
            },
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  ref.read(counter.notifier).state++;
                },
                child: Text('+'),
              ),
              ElevatedButton(
                onPressed: () {
                  ref.read(counter.notifier).state--;
                },
                child: Text('-'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// it use with stateless widget
// class HomeScreen2 extends ConsumerWidget {
//   const HomeScreen2({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     print('home screen 2 build');
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Counter App'),
//       ),
//       body: Column(
//         children: [
//
//           Consumer(builder: (context, ref, child){
//             final count = ref.watch(counter);
//             print('count');
//             return Center(
//               child: Text(count.toString(), style: TextStyle(fontSize: 50),),
//             );
//           }),
//
//           Consumer(builder: (context, ref, child){
//             final count = ref.watch(switchProvider);
//             print('Switch');
//             return Switch(
//                 value: count,
//                 onChanged: (value){
//                   print('onChange Switch');
//                   ref.read(switchProvider.notifier).state = value;
//                 }
//             );
//           }),
//
//
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               ElevatedButton(
//                   onPressed: (){
//                     ref.read(counter.notifier).state++;
//                   },
//                   child: Text('+')
//               ),
//               ElevatedButton(
//                   onPressed: (){
//                     ref.read(counter.notifier).state--;
//                   },
//                   child: Text('-')
//               )
//             ],
//           )
//
//         ],
//       ),
//     );
//   }
// }
