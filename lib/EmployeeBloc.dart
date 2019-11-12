//TODO: imports

//TODO: List of Employee

//TODO: Stream controllers

//TODO: Stream sink getter

//TODO: Constructor - add data; listen to changes

//TODO: Core Functions

//TODO dispose

import 'dart:async';
import './Employee.dart';

class EmployeeBloc {
  //Sink  to add in pipe
  //Stream to get data from pipe
  //by pipe mean dataflow

  List<Employee> _employeelist = [
    Employee(1, "Employee One", 10000.0),
    Employee(1, "Employee Two", 10000.0),
    Employee(2, "Employee Three", 20000.0),
    Employee(3, "Employee Four", 30000.0),
    Employee(4, "Employee Five", 40000.0),
    Employee(5, "Employee Six", 50000.0)
  ];

  final _employeeListStreamController = StreamController<List<Employee>>();

  //for inc and dec
  final _employeeSalaryIncrementStreamController = StreamController<Employee>();
  final _employeeSalaryDecrementStreamController = StreamController<Employee>();

  //getters
  Stream<List<Employee>> get employeeListStream =>
      _employeeListStreamController.stream;
  StreamSink<List<Employee>> get employeeListSink =>
      _employeeListStreamController.sink;
  StreamSink<Employee> get employeeSalaryIncrement =>
      _employeeSalaryIncrementStreamController.sink;
  StreamSink<Employee> get employeeSalaryDecrement =>
      _employeeSalaryDecrementStreamController.sink;

  //Constructor Add Data TO Listen Changes
  EmployeeBloc() {
    _employeeListStreamController.add(_employeelist);
    _employeeSalaryIncrementStreamController.stream.listen(_incrementSalary);
    _employeeSalaryDecrementStreamController.stream.listen(_decrementSalary);
  }

  _incrementSalary(Employee employee) {
    double salary = employee.salary;
    double incrementedSalary = salary * 20 / 100;
    _employeelist[employee.id - 1].salary = salary + incrementedSalary;
    employeeListSink.add(_employeelist);
  }

  _decrementSalary(Employee employee) {
    double salary = employee.salary;
    double decrementedSalary = salary * 20 / 100;
    _employeelist[employee.id - 1].salary = salary - decrementedSalary;
    employeeListSink.add(_employeelist);
  }

  @override
  void dispose() {
    _employeeListStreamController.close();
    _employeeSalaryIncrementStreamController.close();
    _employeeSalaryDecrementStreamController.close();
  }
}
