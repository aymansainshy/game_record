import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GameItemWidget extends StatelessWidget {
  const GameItemWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 125,
        width: double.infinity,
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.local_shipping_outlined,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Transform.translate(
                    offset: const Offset(0, 2),
                    child: Text(
                      "Order No: #}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.black45,
                          ),
                    ),
                  ),
                )
              ],
            ),
            const Spacer(),
            Text(
              "Products :    8 ",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 10),
            Text(
              DateFormat.yMMMMEEEEd().format(DateTime.now()),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
            ),
            const Spacer(),
            Row(
              children: [
                Text(
                  "Total Price :  ",
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        // fontSize: 14,
                      ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: " ${double.tryParse("555.0")?.toStringAsFixed(2)}",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      TextSpan(
                        text: " AED",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.redAccent),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                SizedBox(
                  height: 25,
                  child: Row(
                    children: [
                      Transform.translate(
                        offset: const Offset(0, 3),
                        child: SizedBox(
                          height: 21,
                          child: Text(
                            "Details",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Colors.grey,
                                  // fontSize: 14,
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const RotatedBox(
                        quarterTurns: 0,
                        child: Icon(
                          CupertinoIcons.forward,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
