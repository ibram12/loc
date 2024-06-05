import 'package:flutter/material.dart';
import 'package:loc/core/text_styles/Styles.dart';
import 'package:loc/core/utils/constants.dart';
import 'package:loc/featuers/requests/presentatoin/views/requests_view.dart';
import 'package:loc/featuers/settings/presentaiton/view/drawer_view.dart';


import '../../../../core/server/shered_pref_helper.dart';
import '../widgets/home_view_body.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key,});
  static const String id = "MyHomePage";

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? userName ;
  Future<void> getUserName() async {
  userName =await SherdPrefHelper().getUserName();
  setState(() {});
  }

  @override
  void initState(){
    getUserName();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title:  Text('Wellcome ${userName ?? ''}',style: Styles.textStyle18,),
        leading:   Builder(
          builder: (context) {
            return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(Icons.menu_rounded),
              );
          }
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const UserRequests()));
            },
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      drawer: const DrawerView(),
      body: const HomeVeiwBody(),
    );
  }
}
