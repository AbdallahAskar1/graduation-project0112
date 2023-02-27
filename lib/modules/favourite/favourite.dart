import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../style/icon_broken.dart';
import '../answer/answer.dart';

enum Actions { share, delete, archive }

class FavouuritePage extends StatefulWidget {
  const FavouuritePage({Key? key}) : super(key: key);

  @override
  _FavouuritePageState createState() => _FavouuritePageState();
}

class _FavouuritePageState extends State<FavouuritePage> {
  final List<Map<String, dynamic>> _items = List.generate(
      50,
      (index) => {
            "id": index,
            "title": "question $index",
            "content":
                "This is the answers of question $index. It is very long and you have to expand the tile to see it."
          });

  void _removeItem(int id) {
    setState(() {
      _items.removeWhere((element) => element['id'] == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(milliseconds: 1500),
        content: Text('Item with id #$id has been removed')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Expansion Tile')),
        body: ListView.builder(
            itemCount: _items.length,
            itemBuilder: (_, index) {
              final item = _items[index];
              return Slidable(
                key: Key(item["title"]),
                startActionPane: ActionPane(
                  motion: const StretchMotion(),
                  dismissible: DismissiblePane(
                    onDismissed: () => _removeItem(index),
                  ),
                  children: [
                    SlidableAction(
                      backgroundColor: Colors.blue,
                      icon: IconBroken.Download,
                      label: 'archive',
                      onPressed: (context) => _removeItem(index),
                    ),
                    SlidableAction(
                      backgroundColor: Colors.green,
                      icon: IconBroken.Search,
                      label: 'Share',
                      onPressed: (context) => _removeItem(index),
                    ),
                  ],
                ),
                endActionPane: ActionPane(
                  motion: const BehindMotion(),
                  dismissible: DismissiblePane(
                    onDismissed: () => _removeItem(index),
                  ),
                  children: [
                    SlidableAction(
                      backgroundColor: Colors.red,
                      icon: IconBroken.Delete,
                      label: 'Delete',
                      onPressed: (context) => _removeItem(index),
                    )
                  ],
                ),
                child: Card(
                  key: PageStorageKey(item['id']),
                  color: Colors.lightBlueAccent,
                  elevation: 4,
                  child: ExpansionTile(
                      iconColor: Colors.white,
                      collapsedIconColor: Colors.white,
                      childrenPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      expandedCrossAxisAlignment: CrossAxisAlignment.end,
                      title: Text(
                        item['title'],
                        style: const TextStyle(color: Colors.white),
                      ),
                      children: [
                        Text(item['content'],
                            style: const TextStyle(color: Colors.white)),
                        // This button is used to show this question
                        Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.tealAccent,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.all(Radius.circular(40)),
                            ),

                            child: MaterialButton(
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AnswerRate(
                                          text: item["title"] + item["content"]),
                                    )),
                                child: Text(
                                  'Reanswer',
                                  style: TextStyle(
                                      color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13
                                  ),
                                )),
                          ),
                        )
                        // IconButton(
                        //     onPressed: () => _removeItem(index),
                        //     icon: const Icon(
                        //       IconBroken.Delete,
                        //       color: Colors.redAccent,
                        //     ),),
                      ]),
                ),
              );
            }));
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:my_scan_for_solution/style/icon_broken.dart';
//
// import 'model.dart';
//
// enum Actions { share, delete, archive }
//
// class FavouuritePage extends StatefulWidget {
//   const FavouuritePage({Key? key}) : super(key: key);
//
//   @override
//   State<FavouuritePage> createState() => _FavouuritePageState();
// }
//
// class _FavouuritePageState extends State<FavouuritePage> {
//   List<Users> users = allUsers;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         title: Text(
//           'Characters',
//           style: TextStyle(color: Colors.black),
//         ),
//         centerTitle: true,
//         //leading: Icon(IconBroken.Arrow___Left),
//       ),
//       body: SlidableAutoCloseBehavior(
//         closeWhenOpened: true,
//         child: ListView.builder(
//             itemCount: users.length,
//             itemBuilder: (context, index) {
//               final user = users[index];
//
//               return Slidable(
//                   key: Key(user.name),
//                   startActionPane: ActionPane(
//                     motion: const StretchMotion(),
//                     dismissible: DismissiblePane(
//                       onDismissed: () => _onDismissed(index, Actions.archive),
//                     ),
//                     children: [
//                       SlidableAction(
//                         backgroundColor: Colors.blue,
//                         icon: IconBroken.Download,
//                         label: 'archive',
//                         onPressed: (context) =>
//                             _onDismissed(index, Actions.archive),
//                       ),
//                       SlidableAction(
//                         backgroundColor: Colors.green,
//                         icon: IconBroken.Search,
//                         label: 'Share',
//                         onPressed: (context) =>
//                             _onDismissed(index, Actions.share),
//                       ),
//                     ],
//                   ),
//                   endActionPane: ActionPane(
//                     motion: const BehindMotion(),
//                     dismissible: DismissiblePane(
//                       onDismissed: () => _onDismissed(index, Actions.delete),
//                     ),
//                     children: [
//                       SlidableAction(
//                           backgroundColor: Colors.red,
//                           icon: IconBroken.Delete,
//                           label: 'Delete',
//                           onPressed: (context) =>
//                               _onDismissed(index, Actions.delete))
//                     ],
//                   ),
//                   child: buildUserListTile(user));
//             }),
//       ),
//     );
//   }
//
//   Widget buildUserListTile(Users user) => Builder(builder: (context) {
//         return ListTile(
//           contentPadding: const EdgeInsets.all(16),
//           title: Text(user.name),
//           subtitle: Text(user.email),
//           leading: CircleAvatar(
//             radius: 30,
//             backgroundImage: NetworkImage(user.image),
//           ),
//           onTap: () {
//             final slidable = Slidable.of(context)!;
//             final isClosed =
//                 slidable.actionPaneType.value == ActionPaneType.none;
//             if (isClosed) {
//               slidable.openStartActionPane();
//             } else {
//               slidable.close();
//             }
//           },
//         );
//       });
//
//   _onDismissed(int index, Actions action) {
//     final user = users[index];
//     setState(() => users.removeAt(index));
//     switch (action) {
//       case Actions.delete:
//         _showSnackBar(context, '${user.name} is deleted', Colors.red);
//         break;
//       case Actions.archive:
//         _showSnackBar(context, '${user.name} is archived', Colors.blue);
//         break;
//       case Actions.share:
//         _showSnackBar(context, '${user.name} is shared', Colors.green);
//     }
//   }
// }
//
// void _showSnackBar(BuildContext context, String message, Color color) {
//   final snackBar = SnackBar(
//     content: Text(message),
//     backgroundColor: color,
//   );
//   ScaffoldMessenger.of(context).showSnackBar(snackBar);
// }
