import 'package:flutter/material.dart';

import 'package:webui/constants.dart';
import 'package:webui/responsiveness.dart';
import 'package:webui/services/myfiles.dart';

class myfields extends StatelessWidget {
  const myfields({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "My Files",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text("+  add new"),
            ),
          ],
        ),
        SizedBox(
          height: defaultPadding,
        ),
        responsiveness(
          mobile: gridviewforfiles(
            crossaxiscount: _size.width < 650 ? 2 : 4,
            childaspectratio: _size.width < 660 ? 1.4 : 1,
          ),
          desktop: gridviewforfiles(
            childaspectratio: _size.width < 1300 ? 1.1 : 1.6,
          ),
          tablet: gridviewforfiles(),
        )
      ],
    );
  }
}

class gridviewforfiles extends StatelessWidget {
  const gridviewforfiles({
    Key key,
    @required this.crossaxiscount = 4,
    @required this.childaspectratio = 1,
  }) : super(key: key);

  final int crossaxiscount;
  final double childaspectratio;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: demoMyFiles.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: childaspectratio,
          crossAxisCount: crossaxiscount,
          mainAxisSpacing: defaultPadding,
          crossAxisSpacing: defaultPadding),
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(defaultPadding),
          decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.file_copy),
                ],
              )
            ], //start here
          ),
        );
      },
    );
  }
}
