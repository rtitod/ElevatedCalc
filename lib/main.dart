import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Calculadora Examen 2'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final myController = TextEditingController();
  String saludo = 'Hola';
  double operador1 = 0.0;
  double operador2 = 0.0;
  String operacion = '';
  bool hascalculated = false;
  bool isfirstminus = false;

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  void _onEqualButtonPressed() {
    setState(() {
      String expresion = myController.text;

      if (expresion.startsWith('-')) {
        isfirstminus = true;
        expresion = expresion.substring(1);
      }
      if (expresion.contains('+')) {
        operacion = '+';
      } else if (expresion.contains('-')) {
        operacion = '-';
      } else if (expresion.contains('x')) {
        operacion = 'x';
      } else if (expresion.contains('/')) {
        operacion = '/';
      }

      List<String> operandos = expresion.split(operacion);

      if (operandos.length >= 2) {
        operador1 = double.parse(operandos[0]);
        if (isfirstminus == true){
          operador1 = operador1 * -1;
          isfirstminus = false;
        }
        operador2 = double.parse(operandos[1]);
        double resultado = _realizarOperacion();
        myController.text = resultado.toString();
        hascalculated = true;
      }
    });
  }

  double _realizarOperacion() {
    switch (operacion) {
      case '+':
        return operador1 + operador2;
      case '-':
        return operador1 - operador2;
      case 'x':
        return operador1 * operador2;
      case '/':
        if (operador2 != 0) {
          return operador1 / operador2;
        } else {
          return double.infinity;
        }
      default:
        return 0.0;
    }
  }


  void btnEditTextButtonOnClick() {
    print('Press');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
      ),
      backgroundColor: Colors.grey[200],
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.topRight,
            child: TextField(
              controller: myController,
              style: TextStyle(fontSize: 24),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildButton('7'),
                  _buildButton('8'),
                  _buildButton('9'),
                  _buildButton('/', buttonColor: Colors.grey[300]),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildButton('4'),
                  _buildButton('5'),
                  _buildButton('6'),
                  _buildButton('x', buttonColor: Colors.grey[300]),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildButton('1'),
                  _buildButton('2'),
                  _buildButton('3'),
                  _buildButton('-', buttonColor: Colors.grey[300]),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildButton('+/-'),
                  _buildButton('0'),
                  _buildButton('.'),
                  _buildButton('+', buttonColor: Colors.grey[300]),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: _buildButton('=', buttonColor: Colors.blue),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String buttonText, {Color? buttonColor}) {
    Color defaultColor = Colors.grey[300] ?? Colors.grey; // Color gris claro por defecto

    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(1),
        child: ElevatedButton(
          onPressed: () {
            if (buttonText == '=') {
              _onEqualButtonPressed();
            } else {
              if (hascalculated) {
                if (buttonText == '+/-') {
                  myController.text = "-";
                  hascalculated = false;
                } else {
                  myController.text = buttonText;
                  hascalculated = false;
                }
              } else {
                if (buttonText == '+/-') {
                  myController.text += "-";
                }
                myController.text += buttonText;
              }
            }
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            minimumSize: Size(0, 60),
            primary: buttonText == '=' ? buttonColor : defaultColor,
          ),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}

