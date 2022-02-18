import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webui/screens/navigator_screen.dart';
import 'package:webui/services/states.dart';

class sidemenu extends StatelessWidget {
  const sidemenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            DrawerHeader(
                child: Image.network(
              'https://cdn-icons-png.flaticon.com/512/2917/2917995.png',
              width: 50,
              color: Colors.white54,
            )),
            drawerlisttile(
              title: "Dashborad",
              press: () {
                Provider.of<states>(context, listen: false).setall();
                Provider.of<states>(context, listen: false)
                    .setisdashboard(true);
              },
              iconss: Icons.dashboard,
            ),
            drawerlisttile(
                title: "Chat Random",
                press: () {
                  Provider.of<states>(context, listen: false).setall();
                  Provider.of<states>(context, listen: false)
                      .setischatrandom(true);
                },
                iconss: Icons.payment),
            drawerlisttile(
              title: "Testing ",
              press: () {
                Provider.of<states>(context, listen: false).setall();
                Provider.of<states>(context, listen: false).setistesting(true);
              },
              iconss: Icons.task,
            ),
            drawerlisttile(
              title: "Friends",
              press: () {
                //Provider.of<states>(context, listen: false).setispressed(false);
              },
              iconss: Icons.document_scanner,
            ),
            drawerlisttile(
              title: "Chat",
              press: () {
                Provider.of<states>(context, listen: false).setisstore(true);
              },
              iconss: Icons.store,
            ),
            drawerlisttile(
              title: "dashborad",
              press: () {},
              iconss: Icons.dashboard,
            ),
            drawerlisttile(
              title: "Notification",
              press: () {},
              iconss: Icons.notifications,
            ),
            drawerlisttile(
              title: "Profile",
              press: () {},
              iconss: Icons.notifications,
            ),
            drawerlisttile(
              title: "settings",
              press: () {},
              iconss: Icons.settings,
            ),
          ],
        ),
      ),
    );
  }
}

class drawerlisttile extends StatelessWidget {
  const drawerlisttile({
    Key key,
    @required this.title,
    @required this.iconss,
    @required this.press,
  }) : super(key: key);

  final String title;
  final IconData iconss;
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 0.0,
      onTap: press,
      leading: Icon(
        iconss,
        size: 20,
        color: Colors.white54,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
