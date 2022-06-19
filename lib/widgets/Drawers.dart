import 'package:expense_tracker/resource/auth.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
       Flexible(child: Container(), flex: 1,),
          
            CircleAvatar(
              backgroundImage: NetworkImage('https://images.unsplash.com/photo-1655439192459-f6097c3c2e20?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyOHx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60'),

              radius: 50,
            ),
          
          ListTile(
            title: Text('Name'),
          ),
          ListTile(
            title: Text('Name'),
          ),
          ElevatedButton(onPressed: ()=>Authentication().signOut(), child: Text('Signout')),
        

          Flexible(child: Container(), flex: 5,),
        ],
      ),
    );
  }
}
