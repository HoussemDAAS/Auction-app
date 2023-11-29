// ignore_for_file: file_names

import 'package:auction_app/models/item.model.dart';
import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
 final ItemModel item ;
   const ItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 280,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.orange,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              "assets/money.jfif",
              height: 150,
            ),
            Container(
              height: 100,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Starry Nights Painting by VAN GOGH",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Text("Deadline"),
                    Center(
                        child:
                         SizedBox(
                          width: 180,
                          child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black54,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              20.0), // Adjust the radius as needed
                        ),
                      ),
                      child: const Text(
                        "Voir Plus",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                         )
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
