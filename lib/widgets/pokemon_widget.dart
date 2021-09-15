import 'package:flutter/material.dart';
import 'package:pokemon_app/objects/pokemon_ob.dart';
import 'package:pokemon_app/utils/app_constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
class PokemonWidget extends StatelessWidget {
  PokemonOb pokemon;
  PokemonWidget(this.pokemon);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: (){
          showDetail(context);
        },
        child: Column(
          children: [
            Expanded(
                // child: Image.network(IMG_URL+pokemon.variations[0].image)
              child: CachedNetworkImage(
                imageUrl: IMG_URL+pokemon.variations[0].image,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(child: CircularProgressIndicator(value: downloadProgress.progress,color: Colors.indigoAccent,)),
                errorWidget: (context, url, error) => Icon(Icons.error,color: Colors.red,),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(pokemon.name,style: TextStyle(
                color: Colors.deepOrange,
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),),
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.indigoAccent,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Text(pokemon.variations[0].specie,style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),),
            ),
            SizedBox(height: 5,)
          ],
        ),
      ),
    );
  }
  showDetail(context){
    showDialog(context: context,
        builder: (context){
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            ),
            title: Container(
              color: Colors.indigoAccent,
              padding: EdgeInsets.all(10),
              child: Text(pokemon.name,style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
              ),),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(IMG_URL+pokemon.variations[0].image),
                  Text("Types",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                  ),),
                  Row(
                    children: pokemon.variations[0].types.map((data){
                      return Container(
                        child: Text(data,style: TextStyle(
                          color: Colors.white
                        ),),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.deepOrange
                        ),
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.all(10),
                      );
                    }).toList(),
                  ),
                  Text("Height: ${pokemon.variations[0].height}",style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),),
                  SizedBox(height: 5,),
                  Text("Weight: ${pokemon.variations[0].weight}",style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),),
                  SizedBox(height: 5,),
                  Text("Abilities",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                  ),),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: pokemon.variations[0].abilities.map((data){
                      return Flexible(
                        child: Container(
                          child: Text(data,style: TextStyle(
                              color: Colors.white
                          ),),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.purple
                          ),
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(10),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 5,),
                  Text("Evolutions",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                  ),),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: pokemon.variations[0].evolutions.map((data){
                      return Flexible(
                        child: Container(
                          child: Text(data,style: TextStyle(
                              color: Colors.white
                          ),),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.green
                          ),
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(10),
                        ),
                      );
                    }).toList(),
                  ),
                  Center(
                    child: FlatButton(
                      onPressed: ()=>_launchURL(),
                      child: Text("More Detail",style: TextStyle(
                        color: Colors.white,
                        fontSize: 18
                      ),),
                      color: Colors.indigoAccent,
                    ),
                  )
                ],
              ),
            ),
          );
        }

    );
  }
  void _launchURL() async =>
      await canLaunch(pokemon.link) ? await launch(pokemon.link) : throw 'Could not launch ${pokemon.link}';

}
