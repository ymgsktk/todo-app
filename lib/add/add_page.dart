import 'package:example5/main_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPage extends StatelessWidget {
  final MainModel model;
  AddPage(this.model);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainModel>.value(
      value: model,
      child: Scaffold(
        appBar: AppBar(
          title: Text('TODO'),
        ),
        body: Consumer<MainModel>(builder: (context, model, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: "追加するTODO",
                    hintText: "食事をつくる",
                  ),
                  onChanged: (text) {
                    model.newtodoText = text;
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: () async {
                    await model.add();
                    Navigator.pop(context);
                  },
                  child: Text('追加'),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
