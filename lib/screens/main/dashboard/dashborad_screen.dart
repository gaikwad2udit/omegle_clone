// @dart=2.9

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:webui/constants.dart';
import 'package:webui/containers/chat_layout.dart';
import 'package:webui/containers/chat_screen.dart';

import 'package:webui/responsiveness.dart';
import 'package:webui/screens/main/dashboard/components/chart.dart';
import 'package:webui/screens/main/dashboard/components/header.dart';
import 'package:webui/screens/main/dashboard/components/myfields.dart';
import 'package:webui/screens/main/dashboard/components/strorage_info_card.dart';
import 'package:webui/services/states.dart';

class dashboard_screen extends StatefulWidget {
  const dashboard_screen({Key key}) : super(key: key);

  @override
  State<dashboard_screen> createState() => _dashboard_screenState();
}

class _dashboard_screenState extends State<dashboard_screen> {
  @override
  Widget build(BuildContext context) {
    Provider.of<states>(context);
    return SafeArea(
        child: SingleChildScrollView(
      padding: EdgeInsets.all(defaultPadding),
      child: SingleChildScrollView(
        child: Column(
          children: [
            header(),
            SizedBox(
              height: defaultPadding,
            ),
            if (Provider.of<states>(context).isdashborad)
              defaultcontainer(context),
            if (Provider.of<states>(context).ischatrandom) chat_container(),
            if (Provider.of<states>(
              context,
            ).istesting)
              chat_layout()
          ],
        ),
      ),
    ));
  }

  Row defaultcontainer(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (Provider.of<states>(context).getvalueofstore)
          Container(
            child: Text("hii there"),
          ),
        Expanded(
          flex: 5,
          child: Container(
            //color: Colors.orangeAccent,
            child: Column(
              children: [
                myfields(),
                SizedBox(
                  height: defaultPadding,
                ),
                containerformethod(context),
                if (responsiveness.ismobile(context))
                  SizedBox(
                    height: defaultPadding,
                  ),
                if (responsiveness.ismobile(context)) storagedetails()
              ],
            ),
          ),
        ),
        if (!responsiveness.ismobile(context))
          SizedBox(
            width: defaultPadding,
          ),
        if (!responsiveness.ismobile(context))
          Expanded(
            flex: 2,
            child: storagedetails(),
          )
      ],
    );
  }

  Container containerformethod(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.height) * .5,
      decoration: BoxDecoration(
          color: Provider.of<states>(context, listen: false).getvalue == true
              ? Colors.green
              : Colors.redAccent,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      padding: EdgeInsets.all(defaultPadding),
    );
  }
}

class storagedetails extends StatelessWidget {
  const storagedetails({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(children: [
        Text("storage Deatails",
            style: TextStyle(
              fontWeight: FontWeight.w500,
            )),
        SizedBox(
          height: defaultPadding,
        ),
        chart(),
        storageinfocard(
          amountoffiles: "1.5GB",
          iconss: Icons.document_scanner,
          title: "Documents",
          subtile: "2343 Files",
        ),
        storageinfocard(
          amountoffiles: "1.5GB",
          iconss: Icons.document_scanner,
          title: "Documents",
          subtile: "2343 Files",
        ),
        storageinfocard(
          amountoffiles: "1.5GB",
          iconss: Icons.document_scanner,
          title: "Documents",
          subtile: "2343 Files",
        ),
        storageinfocard(
          amountoffiles: "1.5GB",
          iconss: Icons.document_scanner,
          title: "Documents",
          subtile: "2343 Files",
        ),
      ]),
    );
  }
}
