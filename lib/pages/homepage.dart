
import 'package:care/models/excersiceCard.dart';
import 'package:care/models/health.dart';
import 'package:care/pages/chat.dart';
import 'package:care/pages/exercise.dart';
import 'package:care/pages/health.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' ;


const red = const Color.fromARGB(255, 200, 92, 92);
class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.transparent,
      leading: Padding(padding: const EdgeInsets.all(0.8),
      child: Image.asset("assets/c.png"),),
      leadingWidth: 80,
      actions: [IconButton(onPressed: ()async{ 
            await FirebaseAuth.instance.signOut();
          }, icon: Icon(Icons.logout,color: red,))],

      ),
      // extendBodyBehindAppBar: true,
      bottomNavigationBar: BottomAppBar(color: Colors.transparent,child:Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [IconButton(onPressed: (){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> ChatPage()));
      }, 
      icon: Icon(Icons.chat,color: red,)),
      Icon(Icons.home,color: red,),
      IconButton(onPressed: (){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HealthDetailsPage()));
      }, icon: Icon(Icons.person,color: red,))],),
      ),
      body: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
        
          children: [Padding(
            padding: const EdgeInsets.only(left: 15.0,right: 15.0),
            child: Center(
              child: SizedBox(
              height: 300,
              width: double.infinity,
              child: Container(
                decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(20),
                border: Border.all(color: red,width: 1.5),
                boxShadow: [BoxShadow( color: Colors.black.withOpacity(0.15),
                blurRadius: 20,
                spreadRadius: 2,
                offset: Offset(0, 8),)]),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 180,
                            height: 180,
                            child: CircularProgressIndicator(
                              value: 0.6, // progress (0.0 - 1.0)
                              strokeWidth: 12,
                              color: red,
                              backgroundColor: Colors.grey.shade300,
                            ),
                          ),

                          Image.asset(
                            "assets/robot-hand-pink.PNG",
                            width: 90,
                          ),

                        ],
                      ),

                      SizedBox(height: 15),

                      Text(
                        "3 / 5 Exercises Completed",
                        style: TextStyle(
                          fontFamily: "Times New Roman",
                          fontWeight: FontWeight.bold,
                          color: red,
                          fontSize: 16
                        ),
                      )
                    ],
                  ),
                ),
                
              ),
                    ),
                    
            ),
          ),SizedBox(height: 20,),Padding(
  padding: const EdgeInsets.symmetric(horizontal: 15),
  child: Container(
    height: 120,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: red, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 15,
          offset: Offset(0,6),
        )
      ],
    ),

    child: Padding(
      padding: const EdgeInsets.only(top: 14.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
      
          HealthCircle(
            value: 60,
            min: 50,
            max: 200,
            label: "72 BPM",
            icon: Icons.favorite,
          ),
      
          HealthCircle(
            value: 98,
            max: 100,
            min: 90,
            label: "98%",
            icon: Icons.bloodtype,
          ),
      
          HealthCircle(
            value: 36.8,
            min: 35,
            max: 42,
            label: "36.8°",
            icon: Icons.thermostat,
          ),
      
        ],
      ),
    ),
  ),
          ),SizedBox(height: 20,),
         StreamBuilder<QuerySnapshot>(
  stream: FirebaseFirestore.instance
      .collection('exercise')
      .snapshots(),
  builder: (context, snapshot) {

    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }

    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
      return const Center(child: Text("No exercises found", style : TextStyle(color: red, fontFamily: "Times New Roman") ));
    }
    print(snapshot.data!.docs.length);
    final docs = snapshot.data!.docs;

    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 10),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: docs.length+1,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        childAspectRatio: 3 / 2,
      ),
        itemBuilder: (context, index) {

        if (index == docs.length) {
        return GestureDetector(
          onTap: () {
            print("Add exercise tapped");
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: red),
                boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 6),
              ),
            ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Add Exercise",
                        style: TextStyle(
                          fontFamily: "Times New Roman",
                          fontWeight: FontWeight.bold,
                          color: red
                        ),
                      ),
                      Icon(Icons.add, size: 25, color: red),
                    ],
                  ),
            ],
                    ),
                  ),
          ),
          );
        }


        final data = docs[index].data() as Map<String, dynamic>;
        final title = data['name'];

        return GestureDetector(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>exercisePage(data: data,)));
          },
          child: ExerciseCard(title: title),
        );
      }
          );
        },
      ),],),
      ),
    );
  }
}
