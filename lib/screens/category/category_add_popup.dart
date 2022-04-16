import 'package:flutter/material.dart';
import 'package:money_manger/db/category_db.dart';
import 'package:money_manger/models/category/category_model.dart';

ValueNotifier<CategoryType> selectedCategoryNotifier =
    ValueNotifier(CategoryType.income);

Future<void> showCategoryAddPopup(BuildContext context) async {
  TextEditingController _nameEditingController = TextEditingController();
  showDialog(
    context: context,
    builder: (ctx) {
      return Container(
        padding: const EdgeInsets.all(8),
        child: SimpleDialog(
          elevation: 0,
          title: const Text(
            "Add Category",
            textAlign: TextAlign.center,
          ),
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                controller: _nameEditingController,
                decoration: const InputDecoration(
                  hintText: 'Category Name',
                  border: OutlineInputBorder(
                      // borderRadius: BorderRadius.all(
                      //   Radius.circular(20),
                      // ),
                      ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 2, left: 8, right: 8),
              child: Row(
                children: const [
                  RadioButton(title: 'Income', type: CategoryType.income),
                  RadioButton(title: 'Expense', type: CategoryType.expense),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: ElevatedButton(
                onPressed: () {
                  final _name = _nameEditingController.text;
                  if (_name.isEmpty) {
                    return;
                  }
                  final _type = selectedCategoryNotifier.value;
                  final _category = CategoryModel(
                    id: DateTime.now().microsecondsSinceEpoch.toString(),
                    name: _name,
                    type: _type,
                  );
                  CategoryDb.instance.insertCategory(_category);
                  Navigator.of(ctx).pop();
                },
                child: const Text("Add"),
              ),
            ),
          ],
        ),
      );
    },
  );
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;

  const RadioButton({
    Key? key,
    required this.title,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: selectedCategoryNotifier,
          builder: (BuildContext ctx, CategoryType newCategory, Widget? _) {
            return Radio<CategoryType>(
              value: type,
              groupValue: newCategory,
              onChanged: (value) {
                if (value == null) {
                  return;
                }
                selectedCategoryNotifier.value = value;
                selectedCategoryNotifier.notifyListeners();
              },
            );
          },
        ),
        Text(title),
      ],
    );
  }
}
