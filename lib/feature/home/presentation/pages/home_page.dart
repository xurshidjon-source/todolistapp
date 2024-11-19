import 'package:flutter/material.dart';
import 'package:todolistapp/commons/route/app_route.dart';
import 'package:todolistapp/feature/home/presentation/pages/new_note_page.dart';
import 'package:todolistapp/feature/home/presentation/widgets/note_widget.dart';
import 'package:todolistapp/feature/home/presentation/widgets/search_widget.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigoAccent,
        onPressed: (){
          AppRoute().navigateTo(context, NewNotePage());
        
      },
      child: Text("Add", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(child:
      Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Column(
          children: [
            SizedBox(height: 10,),
            Align(
              alignment: Alignment.topLeft,
                child: Text("ЗАДАЧИ",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 34),)),
            SizedBox(height: 10,),
            SearchWidget(),
            SizedBox(height: 16,),
            Expanded(child: ListView.builder(
              itemCount: 10,
                itemBuilder: (context, index){
              return NoteWidget();
            })),
            

          ],
        ),
      )),
    );
  }
}
