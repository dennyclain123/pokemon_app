import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon_app/objects/pokemon_ob.dart';
import 'package:pokemon_app/objects/response_ob.dart';
import 'package:pokemon_app/pages/home_bloc.dart';
import 'package:pokemon_app/utils/app_constants.dart';
import 'package:pokemon_app/widgets/pokemon_widget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _bloc = HomeBloc();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text("Pokemon App"),
        ),
        body: StreamBuilder<ResponseOb>(
          stream: _bloc.getPokemonStream(),
          initialData: ResponseOb(msgState: MsgState.loading),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            ResponseOb resob = snapshot.data;
            if (resob.msgState == MsgState.data) {
              List<PokemonOb> pmList = resob.data;
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: pmList.length,
                itemBuilder: (context, index) {
                  return PokemonWidget(pmList[index]);
                },
              );
            } else if (resob.msgState == MsgState.error) {
              if (resob.errState == ErrState.serverErr) {
                return Center(child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("500",style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold
                    ),),
                    Text("Internal Server Error",style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                    ),)
                  ],
                ));
              } else if (resob.errState == ErrState.notFoundErr) {
                // return Center(child: Text("404\nContent Not Found"));
                return Center(child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("404",style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold
                    ),),
                    Text("Content Not Found!",style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                    ),)
                  ],
                ));
              } else{
                return Center(child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Something went Wrong!",style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                    ),)
                  ],
                ));
              }
            } else{
              return Center(
                child: CircularProgressIndicator(color: Colors.indigoAccent,),
              );
            }
          },
        ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _bloc.dispose();
  }
}
