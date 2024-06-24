import 'package:flutter/material.dart';
import 'package:state_restoration/src/list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with RestorationMixin {
  final controller = RestorableTextEditingController();
  RestorableBool selected = RestorableBool(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HOME'),
      ),
      body: Column(
        children: [
          TextField(
            controller: controller.value,
          ),
          const SizedBox(height: 50),
          CheckboxListTile(
            title: const Text("Agree"),
            value: selected.value,
            onChanged: (value) {
              selected.value = value ?? false;
              setState(() {});
            },
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              Navigator.restorablePush(
                context,
                navigate,
              );
            },
            child: const Text("Next"),
          ),
        ],
      ),
    );
  }

  @override
  String? get restorationId => 'homeScreen';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(controller, 'text_controller');
    registerForRestoration(selected, 'selected_bool');
  }

  static Route<Object> navigate(BuildContext context, Object? arguments) {
    return MaterialPageRoute(
      builder: (context) => const ListScreen(),
    );
  }
}
