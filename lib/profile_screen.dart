import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List data = [];
  Dio dio = Dio();

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    final response = await dio.get("https://reqres.in/api/users?page=2");
    if (response.statusCode == 200) {
      setState(() {
        data = response.data['data'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
          centerTitle: true,
        ),
        body: ListView.separated(
          itemCount: data.length,
          itemBuilder: (_, i) {
            return ListTile(
              leading: CircleAvatar(
                child: Image.network(data[i]["avatar"]),
              ),
              title: Text(data[i]["first_name"]),
              subtitle: Text(data[i]["email"]),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(height: 15),
        ));
  }
}
