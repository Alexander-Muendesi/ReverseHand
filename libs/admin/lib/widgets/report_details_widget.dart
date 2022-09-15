import 'package:flutter/material.dart';

class ReportDetailsWidget extends StatelessWidget {
  final String reason;
  final String description;
  const ReportDetailsWidget({Key? key, required this.reason, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 25, 8, 8),
      child: SizedBox(
        height: 100,
        width: MediaQuery.of(context).size.width / 1.15,
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark,
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.front_hand_outlined,
                        color: Theme.of(context).primaryColor,
                      ),
                      Text(
                        reason,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.text_snippet_outlined,
                        color: Theme.of(context).primaryColor,
                      ),
                      Text(
                        description,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
