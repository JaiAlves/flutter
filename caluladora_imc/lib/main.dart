import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "Calc imc",
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _infoText="Informe seus dados!";

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetFileds() {
    weightController.text="";
    heightController.text="";
    setState(() {
      _infoText="Informe seus dados!";
      _formKey = GlobalKey<FormState>();//para resetar as msgs de erro dos campos obrigatorio
    });
  }

  void _calculate() {
    setState(() {
      double _peso= double.parse(weightController.text);
      double _altura=double.parse(heightController.text)/100;
      double calculo = _peso/(_altura*_altura);

      String result = calculo.toStringAsPrecision(4);

      if (calculo<16) {
        _infoText= "Subpeso Severo ()";
      } else if(calculo<20) {
        _infoText= "Subpeso ($result)";
      } else if(calculo<25) {
        _infoText= "Normal ($result)";
      } else if(calculo<30) {
        _infoText= "Sobrepeso ($result)";
      } else if(calculo<40) {
        _infoText= "Obeso ($result)";
      } else {
        _infoText= "Obeso Mórbido ($result)";
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _resetFileds();
            },
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.person_outline,
                size: 120,
                color: Colors.green,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: weightController,
                validator: (value) {
                  if(value.isEmpty) {
                    return "Insira seu peso!";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: heightController,
                validator: (value) {
                  if(value.isEmpty) {
                    return "Insira a sua altura!";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50,
                  child: RaisedButton(
                    color: Colors.green,
                    onPressed: () {
                      if(_formKey.currentState.validate()){
                        _calculate();
                      }
                    },
                    child: Text("Calcular", style: TextStyle(color: Colors.white, fontSize: 25.0),)
                    ,
                  ),
                ),
              ),

              Text(_infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
