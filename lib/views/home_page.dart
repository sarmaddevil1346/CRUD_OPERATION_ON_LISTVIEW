import 'package:flutter/material.dart';

import '../models/contact_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ContactModel> contactList = [];
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController numberEditingController = TextEditingController();

  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact App"),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: nameEditingController,
            decoration: const InputDecoration(
                hintText: "Enter contact",
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: numberEditingController,
            decoration: const InputDecoration(
              hintText: "Enter contact",
              filled: true,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  final name = nameEditingController.text.toString().trim();
                  final number = numberEditingController.text.toString().trim();

                  setState(() {
                    contactList.add(
                      ContactModel(
                        name: name,
                        phone: number,
                      ),
                    );
                    nameEditingController.text = "";
                    numberEditingController.text = "";
                  });
                },
                child: const Text("Save"),
              ),
              ElevatedButton(
                onPressed: () {
                  final name = nameEditingController.text.toString().trim();
                  final number = numberEditingController.text.toString().trim();

                  setState(() {
                    contactList[selectedIndex].name = name;
                    contactList[selectedIndex].phone = number;
                    selectedIndex = -1;

                    nameEditingController.text = "";
                    numberEditingController.text = "";
                  });
                },
                child: const Text("update"),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: contactList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const CircleAvatar(),
                  title: Text(contactList[index].name),
                  subtitle: Text(contactList[index].phone.toString()),
                  trailing: SizedBox(
                    width: 70,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              contactList.removeAt(index);
                            });
                          },
                          child: const Icon(Icons.edit),
                        ),
                        InkWell(
                            onTap: () {
                              setState(() {
                                nameEditingController.text =
                                    contactList[index].name;
                                numberEditingController.text =
                                    contactList[index].phone;
                                selectedIndex = index;
                              });
                            },
                            child: const Icon(Icons.delete)),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
