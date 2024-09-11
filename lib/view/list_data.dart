import 'package:flutter/material.dart';
import 'package:google_keep/functions/functions.dart';
import 'package:google_keep/models/data.dart';
import 'package:google_keep/view/add_data.dart';
import 'package:google_keep/view/datapage.dart';
import 'package:google_keep/view/editpage.dart';

class ListData extends StatefulWidget {
  const ListData({super.key});

  @override
  State<ListData> createState() => _ListDataState();
}

class _ListDataState extends State<ListData> {
  String search = '';
  List<Data> searchedList = [];
  void searchListUpdate() {
    getData();
    searchedList = dataListNotifier.value
        .where((stdModel) => stdModel.title!.toLowerCase().contains(search))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    searchListUpdate();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 14),
              width: 352,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 114, 112, 112)
                        .withOpacity(0.5),
                  ),
                ],
              ),
              child: TextFormField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 7),
                    prefixIcon: Icon(Icons.search_rounded),
                    hintText: "Search your notes",
                    border: InputBorder.none),
                onChanged: (value) {
                  setState(() {
                    search = value;
                    searchListUpdate();
                  });
                },
              ),
            ),
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 255, 9, 9),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddData(),
              ));
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: dataListNotifier,
              builder:
                  // ignore: avoid_types_as_parameter_names
                  (BuildContext, List<Data> dataList, Widget? child) {
                return search.isNotEmpty
                    ? searchedList.isEmpty
                        ? const Center(
                            child: Text(
                              'No results found.',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        : _buildDataList(searchedList)
                    : _buildDataList(dataList);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataList(List<Data> datas) {
    return datas.isEmpty
        ? Center(child: Text('No Notes Entered'))
        : ListView.separated(
            shrinkWrap: true,
            itemCount: datas.length,
            itemBuilder: (context, index) {
              final data = datas[index];
              return Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => dataPage(
                            title: data.title, description: data.description),
                      ),
                    );
                  },
                  title: Text(
                    data.title.toString(),
                    style: TextStyle(
                        fontSize: 18,
                        color: const Color.fromARGB(255, 191, 24, 24)),
                  ),
                  subtitle: Text(
                    data.description ?? "",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Editpage(
                                title: data.title,
                                description: data.description,
                                index: index,
                              ),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Colors.amber,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            deleteData(index);
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.amber,
                          ))
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Divider(
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              );
            },
          );
  }
}
