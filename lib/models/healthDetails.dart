import 'package:care/models/emergency.dart';

class Healthdetails {
  final String name;
  final String dob;
  final double height;
  final double weight;
  final String bloodGroup;
  final String allergies;
  final String medications; 
  final String doctorName;
  final String doctorPhone;
  final List<EmergencyContact> emergencyContact;
  Healthdetails({
    required this.name,
    required this.dob,
    required this.height,
    required this.weight,
    required this.bloodGroup,
    required this.allergies,
    required this.medications,
    required this.doctorName,
    required this.doctorPhone,
    required this.emergencyContact
  });

  Map <String,dynamic> toMap(){
  return{
    'name' : name,
    'dob' : dob,
    'height' : height,
    'weight' : weight,
    'bloodGroup' : bloodGroup,
    'allergies' : allergies,
    'medications' : medications,
    'doctorName' : doctorName,
    'doctorPhone' : doctorPhone,
    'emergencyContact' : emergencyContact.map((e) => e.toMap()).toList(),
  };
  }

  factory Healthdetails.fromMap(Map<String,dynamic> map){
    return Healthdetails(name: map['name'], 
    dob: map['dob'],
    height: (map['height'] as num).toDouble(), 
    weight: (map['weight'] as num).toDouble(), 
    bloodGroup: map['bloodGroup'], 
    allergies: map['allergies'], 
    medications: map['medications'], 
    doctorName: map['doctorName'], 
    doctorPhone: map['doctorPhone'], 
        emergencyContact: (map['emergencyContact'] as List? ?? [])
        .map((e) => EmergencyContact.fromMap(e))
        .toList(),);
  }

}