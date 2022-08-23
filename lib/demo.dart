import 'package:apicall/profile_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Demo extends StatefulWidget {
  const Demo({Key? key}) : super(key: key);

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  TextEditingController FullName = TextEditingController();
  TextEditingController JobName = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  List dataList = [];
  Dio dio = Dio();

  void addData(String name, String job) async {
    Response response = await dio
        .post("https://reqres.in/api/users", data: {"name": name, "job": job});
    if (response.statusCode == 201) {
      setState(() {
        dataList.add(response.data);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8, top: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text("Full Name"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Form(
                    key: _formkey,
                    child: Column(children: [
                      TextFormField(
                          validator: (value) {
                            return value != null && value.isEmpty
                                ? "This field is required"
                                : null;
                          },
                          controller: FullName,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))))),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Job Name"),
                          TextFormField(
                              validator: (value) {
                                return value != null && value.isEmpty
                                    ? "This field is required"
                                    : null;
                              },
                              controller: JobName,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))))),
                        ],
                      ),
                      const SizedBox(
                        height: 400,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_formkey.currentState!.validate()) {
                            addData(FullName.text, JobName.text);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing...')),
                            );
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ProfileScreen()));
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: const BoxDecoration(
                              color: Colors.blue,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: const Text(
                            "Submit",
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          ),
                        ),
                      )
                    ])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
