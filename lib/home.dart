// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, body_might_complete_normally_nullable, sized_box_for_whitespace

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _info = "Informe seus dados.";
  final String _INFO_DEFAULT = "Informe seus dados.";

  String _imc = "";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController pesoTextController = TextEditingController();
  TextEditingController alturaTextController = TextEditingController();

  void _calcular(){
    setState(()
    {
      double peso = double.parse(pesoTextController.text);
      double altura = double.parse(alturaTextController.text) / 100;
      double imc = peso / ( altura * altura);
      if(imc < 18.6){
        _info = 'Abaixo do Peso';
        _imc = imc.toStringAsPrecision(3);
      } else if(imc >= 18.6 && imc < 24.9){
        _info = 'Peso Ideal';
      } else if(imc >= 24.9 && imc < 29.9){
        _info = 'Levemente Acima do Peso';
      } else if(imc >= 29.9 && imc < 34.9){
        _info = 'Obesidade I';
      } else if(imc >= 34.9 && imc < 39.9){
        _info = 'Obesidade II';
      } else if(imc >= 40){
        _info = 'Obesidade III';
      }
      _imc = imc.toStringAsPrecision(3);
    });
  }

  void _resetar(){
    pesoTextController.text = "";
    alturaTextController.text = '';
    setState(() {
      _info = _INFO_DEFAULT;
      _imc = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          backgroundColor: Colors.blue,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.only(left:10,right: 10, top: 10),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Peso (kg)",
                        labelStyle: TextStyle(color: Colors.blueAccent)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blueAccent, fontSize: 16.0),
                    controller: pesoTextController,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Insira seu Peso!";
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Altura (cm)",
                        labelStyle: TextStyle(color: Colors.blueAccent)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blueAccent, fontSize: 16.0),
                    controller: alturaTextController,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Insira sua Altura!";
                      }
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 40.0, bottom: 10.0),
                    child: Container(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: (){
                          if(_formKey.currentState!.validate()){
                            _calcular();
                          }
                        },
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent)),
                        child: Text('Calcular',style: TextStyle(color: Colors.white, fontSize: 16.0),),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: (){
                            _resetar();
                        },
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent)),
                        child: Text('Resetar',style: TextStyle(color: Colors.white, fontSize: 16.0),),
                      ),
                    ),
                  ),
                  Text(_info,
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.blueAccent, fontSize: 16),
                  ),
                 _imc != "" ?
                    Text(_imc,
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.blueAccent, fontSize: 16),
                    )
                     : Container()
                ],
              ),
            )
        )
    );
  }
}
