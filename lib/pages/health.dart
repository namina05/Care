import 'package:care/models/emergency.dart';
import 'package:care/pages/homepage.dart';
import 'package:care/service/healthservice.dart';
import 'package:flutter/material.dart';
import 'package:care/models/healthdetails.dart';

const Color dRed = const Color.fromARGB(255, 199, 33, 33);
const Color red = const Color.fromARGB(255, 200, 92, 92);
const String font = "Times New Roman";
const TextStyle textstyle = TextStyle(color:dRed ,fontWeight: FontWeight.bold,fontFamily: font);



class HealthDetailsPage extends StatefulWidget {

  const HealthDetailsPage({super.key});

  @override
  State<HealthDetailsPage> createState() => _HealthDetailsPageState();
}

class _HealthDetailsPageState extends State<HealthDetailsPage> {

  bool isEditing = false;

  late TextEditingController name;
  late TextEditingController dob;
  late TextEditingController height;
  late TextEditingController weight;
  late TextEditingController blood;
  late TextEditingController allergies;
  late TextEditingController medications;
  late TextEditingController doctorName;
  late TextEditingController doctorPhone;
  late List<TextEditingController> contactNames;
  late List<TextEditingController> contactPhones;

@override
void initState() {
  super.initState();

  name = TextEditingController();
  dob = TextEditingController();
  height = TextEditingController();
  weight = TextEditingController();
  blood = TextEditingController();
  allergies = TextEditingController();
  medications = TextEditingController();
  doctorName = TextEditingController();
  doctorPhone = TextEditingController();

  contactNames = [];
  contactPhones = [];

  loadHealth();
}

  Widget buildField(String label, IconData icon, TextEditingController controller,
      {TextInputType type = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        enabled: isEditing,
        keyboardType: type,
        onChanged: (_) => setState(() {}),
        style: TextStyle(color:red
         ,fontWeight: FontWeight.bold,fontFamily: font),
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          labelText: label,
          labelStyle:  TextStyle(color:red ,fontWeight: FontWeight.bold,fontFamily: font),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget sectionCard(String title, List<Widget> children) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontFamily: font,
                color: dRed,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ...children
          ],
        ),
      ),
    );
  }

  Widget buildEmergencyContacts() {
  return Column(
    children: List.generate(contactNames.length, (index) {
      return Column(
        children: [
          buildField(
            "Contact Name",
            Icons.person,
            contactNames[index],
          ),
          buildField(
            "Phone",
            Icons.phone,
            contactPhones[index],
            type: TextInputType.phone,
          ),
          const SizedBox(height: 10),
        ],
      );
    }),
  );
}

Future<void> loadHealth() async {
  final health = await HealthService().getHealth();

  if (health == null) return;

  setState(() {
    name.text = health.name;
    dob.text = health.dob;
    height.text = health.height.toString();
    weight.text = health.weight.toString();
    blood.text = health.bloodGroup;
    allergies.text = health.allergies;
    medications.text = health.medications;
    doctorName.text = health.doctorName;
    doctorPhone.text = health.doctorPhone;

    contactNames = health.emergencyContact
        .map((c) => TextEditingController(text: c.name))
        .toList();

    contactPhones = health.emergencyContact
        .map((c) => TextEditingController(text: c.phone))
        .toList();
  });
}
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 251, 246, 245),

      appBar: AppBar(
        leading: IconButton(onPressed: (){Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Homepage()));}, icon: Icon(Icons.arrow_back,color: dRed,)),
        title: const Text("Health Profile",style: textstyle),
        // centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.save : Icons.edit,color: dRed,),
            onPressed: () async{
               if (isEditing) {
                  List<EmergencyContact> contacts = List.generate(
                    contactNames.length,
                    (i) => EmergencyContact(
                      name: contactNames[i].text,
                      phone: contactPhones[i].text,
                    ),
                  );

                  Healthdetails updatedHealth = Healthdetails(
                    name: name.text,
                    dob: dob.text,
                    height: double.tryParse(height.text)??0,
                    weight: double.tryParse(weight.text)??0,
                    bloodGroup: blood.text,
                    allergies: allergies.text,
                    medications: medications.text,
                    doctorName: doctorName.text,
                    doctorPhone: doctorPhone.text,
                    emergencyContact: contacts,
                  );
                await HealthService().saveHealth(updatedHealth);
               }
              setState(() {
                isEditing = !isEditing;
              });
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// Profile Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 199, 33, 33),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [

                  const CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 40, color:  Color.fromARGB(255, 199, 33, 33)),
                  ),

                  const SizedBox(width: 16),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name.text,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          blood.text,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// Personal Info
            sectionCard("Personal Information", [
              buildField("Name", Icons.person, name),
              buildField("Date of Birth", Icons.cake, dob),
              buildField("Height (cm)", Icons.height, height,
                  type: TextInputType.number),
              buildField("Weight (kg)", Icons.monitor_weight, weight,
                  type: TextInputType.number),
            ]),

            /// Medical
            sectionCard("Medical Information", [
              buildField("Blood Group", Icons.bloodtype, blood),
              buildField("Allergies", Icons.warning_amber, allergies),
              buildField("Medications", Icons.medication, medications),
            ]),

            /// Doctor
            sectionCard("Doctor Information", [
              buildField("Doctor Name", Icons.local_hospital, doctorName),
              buildField("Doctor Phone", Icons.phone, doctorPhone,
                  type: TextInputType.phone),
            ]),

            sectionCard("Emergency Contact", [
              buildEmergencyContacts(),
              if (isEditing)
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      contactNames.add(TextEditingController());
                      contactPhones.add(TextEditingController());
                    });
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Add Contact"),
                ),
            ]),


          ],
        ),
      ),
    );
  }
  @override
void dispose() {
  name.dispose();
  dob.dispose();
  height.dispose();
  weight.dispose();
  blood.dispose();
  allergies.dispose();
  medications.dispose();
  doctorName.dispose();
  doctorPhone.dispose();

  for (var c in contactNames) {
    c.dispose();
  }

  for (var c in contactPhones) {
    c.dispose();
  }

  super.dispose();
}
}