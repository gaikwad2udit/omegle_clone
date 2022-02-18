import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:webui/constants.dart';
import 'package:webui/controllers/menucontroller.dart';
import 'package:webui/responsiveness.dart';
import 'package:provider/provider.dart';

class header extends StatelessWidget {
  const header({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!responsiveness.isdesktop(context))
          IconButton(
              onPressed: context.read<menucontroller>().controlmenu,
              icon: Icon(Icons.menu)),
        // if (!responsiveness.ismobile(context))
        Text("Dashboard"),
        if (FirebaseAuth.instance.currentUser.isAnonymous)
          Padding(
            padding: const EdgeInsets.only(left: defaultPadding),
            child: Text('Anonmyous User'),
          ),
        Spacer(
          flex: responsiveness.ismobile(context) ? 2 : 1,
        ),
        Expanded(
          child: searchfield(),
        ),
        profilecard()
      ],
    );
  }
}

class profilecard extends StatelessWidget {
  const profilecard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: defaultPadding),
      padding: EdgeInsets.symmetric(
          horizontal: defaultPadding, vertical: defaultPadding / 2),
      decoration: BoxDecoration(
        color: secondaryColor,
        border: Border.all(color: Colors.white54),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: [
          Icon(Icons.person),
          if (!responsiveness.ismobile(context))
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: Text("vashu sinha"),
            ),
          Icon(Icons.keyboard_arrow_down)
        ],
      ),
    );
  }
}

class searchfield extends StatelessWidget {
  const searchfield({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        fillColor: secondaryColor,
        filled: true,
        hintText: "Search",
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            width: 40,
            // padding: EdgeInsets.all(defaultPadding * 0.75),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: primaryColor,
            ),
            child: Icon(
              Icons.search,
              size: 18,
            ),
          ),
        ),
      ),
    );
  }
}
