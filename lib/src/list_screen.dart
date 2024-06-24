import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> with RestorationMixin {
  RestorableInt scrolledIndex = RestorableInt(0);
  final ItemScrollController itemScrollController = ItemScrollController();
  final itemPositionsListener = ItemPositionsListener.create();

  @override
  void initState() {
    super.initState();
    addListener();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      scrollToIndex();
    });
  }

  void addListener() {
    itemPositionsListener.itemPositions.addListener(() {
      scrolledIndex.value =
          itemPositionsListener.itemPositions.value.first.index;
    });
  }

  void scrollToIndex() {
    if (scrolledIndex.value == 0) return;
    itemScrollController.scrollTo(
      index: scrolledIndex.value,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List Screen"),
      ),
      body: ScrollablePositionedList.builder(
        initialScrollIndex: scrolledIndex.value,
        itemCount: 50,
        itemScrollController: itemScrollController,
        itemPositionsListener: itemPositionsListener,
        itemBuilder: (context, index) {
          return Container(
            color: Colors.red,
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(20),
            child: Center(child: Text("Index $index")),
          );
        },
      ),
    );
  }

  @override
  String? get restorationId => 'list-scroll';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(scrolledIndex, 'scroll-index');
  }
}
