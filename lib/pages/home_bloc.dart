import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokemon_app/objects/pokemon_ob.dart';
import 'package:pokemon_app/objects/response_ob.dart';
import 'package:pokemon_app/utils/app_constants.dart';


class HomeBloc{
  StreamController<ResponseOb> _controller = StreamController<ResponseOb>();
  Stream<ResponseOb> getPokemonStream() => _controller.stream;

  getData()async{
    ResponseOb resob = ResponseOb(msgState: MsgState.loading);
    _controller.sink.add(resob);
    var response = await http.get(Uri.parse(BASE_URL));
    if(response.statusCode==200){
      // print(response.body);
      List<dynamic> list = json.decode(response.body);
      List<PokemonOb> pmList = [];
      list.forEach((data) {
        pmList.add(PokemonOb.fromJson(data));
      });
      resob.msgState = MsgState.data;
      resob.data = pmList;
      _controller.sink.add(resob);
    }else if(response.statusCode==500){
      resob.msgState = MsgState.error;
      resob.errState = ErrState.serverErr;
      _controller.sink.add(resob);
    }else if(response.statusCode==404){
      resob.msgState = MsgState.error;
      resob.errState = ErrState.notFoundErr;
      _controller.sink.add(resob);
    } else{
      // print("Error");
      resob.msgState = MsgState.error;
      resob.errState = ErrState.unknownErr;
      _controller.sink.add(resob);
    }
  }
  dispose(){
    _controller.close();
  }
}
