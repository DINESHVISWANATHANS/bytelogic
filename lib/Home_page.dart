import 'package:bytelogik/providers/auth_provider.dart';
import 'package:bytelogik/providers/riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(riverPodhard);
    final counter = provider.counter;
    final myColors = provider.myColors;
    final uid = FirebaseAuth.instance.currentUser?.uid ?? "";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 217, 222, 248),
        actions: [
          IconButton(
            onPressed: () async {
              await ref.read(authProvider).logout();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Container(
        color: Color.fromARGB(255, 217, 222, 248),
        child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          children: [
            Text(
              counter.toString(),
              style: TextStyle(
                color: Color.fromARGB(255, 2, 14, 70),
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 100),
            Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Color.fromARGB(255, 178, 188, 231),
                  width: 2,
                ),
              ),
              child: Column(
                mainAxisAlignment: .center,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          box(
                            myColors[11 - 1],
                            const Color.fromARGB(255, 190, 216, 236),
                          ),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          box(
                            myColors[7 - 1],
                            const Color.fromARGB(255, 166, 182, 250),
                          ),
                          box(
                            myColors[10 - 1],
                            const Color.fromARGB(255, 196, 171, 255),
                          ),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          box(
                            myColors[6 - 1],
                            const Color.fromARGB(255, 196, 171, 255),
                          ),
                          box(
                            myColors[4 - 1],
                            const Color.fromARGB(255, 190, 216, 236),
                          ),
                          box(
                            myColors[9 - 1],
                            const Color.fromARGB(255, 166, 182, 250),
                          ),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          box(
                            myColors[5 - 1],
                            const Color.fromARGB(255, 190, 216, 236),
                          ),
                          box(
                            myColors[2 - 1],
                            const Color.fromARGB(255, 166, 182, 250),
                          ),
                          box(
                            myColors[1 - 1],
                            const Color.fromARGB(255, 185, 197, 248),
                          ),
                          box(
                            myColors[3 - 1],
                            const Color.fromARGB(255, 187, 162, 247),
                          ),
                          box(
                            myColors[8 - 1],
                            const Color.fromARGB(255, 190, 216, 236),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 100),
            Row(
              mainAxisAlignment: .spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    if (counter >= 1) {
                      ref.read(riverPodhard).removecounter(uid, ref);
                    }
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Color.fromARGB(255, 2, 14, 70),
                        width: 2,
                      ),
                    ),
                    child: Image.asset(
                      "asset/image/minus.png",
                      color: Color.fromARGB(255, 2, 14, 70),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    ref.read(riverPodhard).resetcounter(uid, ref);
                  },
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: Image.asset("asset/image/undo.png"),
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    if (counter < 11) {
                      ref.read(riverPodhard).addcounter(uid, ref);
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            title: Text(
                              "Trial Limit Reached",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 2, 14, 70),
                              ),
                            ),
                            content: Text(
                              "Your free trial is over. To increase the counter further, please upgrade your plan.",
                              style: TextStyle(fontSize: 16),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color.fromARGB(
                                    255,
                                    2,
                                    14,
                                    70,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Upgrade",style: TextStyle(
                                   color: Colors.white
                                ),),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Color.fromARGB(255, 2, 14, 70),
                        width: 2,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "asset/image/add.png",
                        color: Color.fromARGB(255, 2, 14, 70),
                      ),
                    ),
                  ),
                ),
 
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget box(bool active, Color color) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: active
          ? Container(height: 40, width: 40, color: color)
          : const SizedBox(height: 40, width: 40),
    );
  }
}
