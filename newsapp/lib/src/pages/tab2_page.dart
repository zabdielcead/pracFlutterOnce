import 'package:flutter/material.dart';
import 'package:newsapp/src/models/category_models.dart';
import 'package:newsapp/src/services/news_service.dart';
import 'package:newsapp/src/theme/tema.dart';
import 'package:newsapp/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return SafeArea(
          child: Scaffold(
              body: Column(
                      children: <Widget>[
                           _ListaCategorias(),
                           Expanded(child: ListaNoticias(newsService.getArticulosCategoriaSeleccionada))
                      ] 
                    ),
          ),
    );
  }
}

class _ListaCategorias extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;
    return Container(
              width: double.infinity,
              height: 80,
              color: Colors.red,
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),// para que sean igual en android y IOS
                  scrollDirection: Axis.horizontal ,
                  itemCount: categories.length,
                  itemBuilder: (BuildContext context, int index){
                    final cName = categories[index].name;
                    return Padding(
                    //categories[index].name
                              padding: EdgeInsets.all(8),
                              child: Column(
                                children: 
                                  <Widget>[
                                    _CategoryWidget(categories[index]),
                                    SizedBox( height: 5),
                                    Text('${cName[0].toUpperCase()}${cName.substring(1)}')
                                  ]
                              ),
                            );
                    }
              ),
    );
  }
}

class _CategoryWidget extends StatelessWidget {

  final Category categoria;

  const _CategoryWidget(this.categoria);

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    return GestureDetector(
          onTap: (){
            print('tap ${categoria.name}');
            final newService = Provider.of<NewsService>(context, listen: false);
            newService.selectedCategory = categoria.name;
          },
          child: Container(
                width: 40,
                height: 40,
                margin: EdgeInsets.symmetric(),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white
                ),
              child: Icon(
                        categoria.icon,
                        color:   (categoria.name == newsService.selectedCategory)
                                    ? miTema.accentColor
                                    : Colors.black54,

                      ),
           ),
    );
  }
}