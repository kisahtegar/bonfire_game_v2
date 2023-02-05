import 'package:flutter/material.dart';

import 'localization/strings_location.dart';

class Dialogs {
  // GameOver
  static void showGameOver(BuildContext context, VoidCallback playAgain) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                'assets/game_over.png',
                height: 100,
              ),
              const SizedBox(
                height: 10.0,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                ),
                onPressed: playAgain,
                child: Text(
                  getString('play_again_cap'),
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Normal',
                      fontSize: 20.0),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  // Congratulations End game
  static void showCongratulations(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Material(
          color: Colors.transparent,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  getString('congratulations'),
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Normal',
                      fontSize: 30.0),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: Text(
                    getString('thanks'),
                    style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Normal',
                        fontSize: 18.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 118, 82, 78)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ),
                  child: const Text("OK",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Normal',
                          fontSize: 17.0)),
                  onPressed: () {
                    // Navigator.of(context).pushAndRemoveUntil(
                    //   MaterialPageRoute(builder: (context) => Menu()),
                    //   (Route<dynamic> route) => false,
                    // );
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
