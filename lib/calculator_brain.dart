

import 'dart:math';

import 'package:flutter/foundation.dart';

class CalculatorBrain{

  CalculatorBrain({@required this.weight,@required this.height});

  final int height;
  final int weight;

  double _BMI;

  String calculateBMI(){

     _BMI = weight / pow(height / 100, 2);
    return _BMI.toStringAsFixed(1);

  }

  String getResult(){
    if(_BMI>=25){
      return 'Overweight';
    }
    else if(_BMI>=18.5){
      return 'Normal';
    }
    else{
      return 'UnderWeight';
    }
  }

  String getInterpretation(){
    if(_BMI>=25){
      return 'you have a higher than normal body weight. try to do exercise more.';
    }
    else if(_BMI>=18.5){
      return 'you have a normal body weight. Good job!';
    }
    else{
      return 'You have a lower than normal body weight. You need to be eating more.';
    }
  }
}