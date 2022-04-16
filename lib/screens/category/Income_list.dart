import 'package:flutter/material.dart';
import 'package:money_manger/db/category_db.dart';
import 'package:money_manger/models/category/category_model.dart';

class IncomeList extends StatelessWidget {
  const IncomeList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDb().incomeCategoryListListener,
      builder: (BuildContext ctx, List<CategoryModel> newlist, Widget? _) {
        return ListView.separated(
            padding: const EdgeInsets.all(8),
            itemBuilder: (ctx, index) {
              final category = newlist[index];
              return Card(
                child: ListTile(
                  title: Text(category.name),
                  trailing: IconButton(
                    onPressed: () {
                      CategoryDb.instance.deleteCategory(category.id);
                    },
                    icon: const Icon(
                      Icons.delete_forever_rounded,
                      color: Colors.purple,
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 10,
              );
            },
            itemCount: newlist.length);
      },
    );
  }
}
