import 'package:flutter/material.dart';
import 'package:money_manger/db/category_db.dart';
import 'package:money_manger/models/category/category_model.dart';
import 'package:money_manger/screens/category/category_add_popup.dart';
import 'package:money_manger/screens/category/category_screen.dart';
import 'package:money_manger/screens/home/widgets/bottom_navigation.dart';
import 'package:money_manger/screens/transaction/add_transaction.dart';
import 'package:money_manger/screens/transaction/transaction_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  final _pages = const [
    TransactionScreen(),
    CategoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "MONEY MANAGER",
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: const BottomNavigation(),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedIndexNotifier,
          builder: (BuildContext context, int updatedIndex, _) {
            return _pages[updatedIndex];
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedIndexNotifier.value == 0) {
            print('Add Transactions');
            Navigator.of(context).pushNamed(ScreenAddTransaction.routeName);
          } else {
            // final _sample = CategoryModel(
            //   id: DateTime.now().millisecondsSinceEpoch.toString(),
            //   name: 'Travel to Landon',
            //   type: CategoryType.expense,
            // );
            // CategoryDb().insertCategory(_sample);
            print('Add Category');
            showCategoryAddPopup(context);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
