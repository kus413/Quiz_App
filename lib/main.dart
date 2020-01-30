import 'package:flutter/material.dart';
import 'package:quiz_app/question_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuestionBrain questionBrain = new QuestionBrain();

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
  int scoreCount = 0;

  void checkAnswer({bool userAnswer}) {
    setState(() {
      if (questionBrain.isFinished()) {
        Alert(
          context: context,
          title: "Final Score",
          desc: "$scoreCount",
          buttons: [
            DialogButton(
              child: Text("Play Again"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ).show();
        questionBrain.resetQuestion();
        scoreKeeper.clear();
        scoreCount = 0;
      } else {
        if (questionBrain.getAnswerResult() == userAnswer) {
          scoreKeeper.add(Icon(
            Icons.check,
            color: Colors.green,
            size: 24.0,
          ));
          scoreCount++;
        } else {
          scoreKeeper.add(Icon(
            Icons.close,
            color: Colors.red,
            size: 24.0,
          ));
        }
        questionBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              child: Text(
                "Your Score ",
                style: TextStyle(color: Colors.white, fontSize: 24.0),
              ),
            ),
            Container(
              child: Text(
                "$scoreCount",
                style: TextStyle(color: Colors.white, fontSize: 50.0),
              ),
            ),
          ],
        ),
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questionBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: FlatButton(
              color: Colors.green,
              child: Text(
                "True",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(userAnswer: true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                "False",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(userAnswer: false);
              },
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: scoreKeeper,
          ),
        )
      ],
    );
  }
}
