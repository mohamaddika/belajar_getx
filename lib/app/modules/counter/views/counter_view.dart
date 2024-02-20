import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/counter_controller.dart';

class CounterView extends StatelessWidget {
  CounterView({Key? key}) : super(key: key);

  final CounterController controller = Get.put(CounterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CounterView'),
        centerTitle: true,
      ),
      body: Center(
        child: Obx(
          () => Text(
            'Count: ${controller.count}',
            style: TextStyle(fontSize: controller.count.toDouble()),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                if (controller.count > 1) {
                  controller.decremet();
                } else {
                  Get.snackbar(
                    'Error', 'Habeun we di kurangan 1',
                    snackPosition: SnackPosition.TOP,
                    // backgroundColor: Colors.grey
                  );
                }
              },
              child: Icon(Icons.remove),
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.count < 20) {
                  controller.increment();
                } else {
                  Get.snackbar('Error', 'Habeun we di tambahan 20',
                      snackPosition: SnackPosition.TOP);
                }
              },
              child: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
