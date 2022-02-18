import 'package:flutter/material.dart';
import 'package:webui/constants.dart';

class storageinfocard extends StatelessWidget {
  const storageinfocard({
    Key key,
    @required this.amountoffiles,
    @required this.subtile,
    @required this.title,
    @required this.iconss,
  }) : super(key: key);

  final String title, subtile, amountoffiles;
  final IconData iconss;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(width: 2, color: primaryColor.withOpacity(0.15))),
      child: Row(
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: Icon(iconss),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  subtile,
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(color: Colors.white70),
                )
              ],
            ),
          )),
          Text(amountoffiles),
        ],
      ),
    );
  }
}
