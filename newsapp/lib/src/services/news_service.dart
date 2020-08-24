import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsapp/src/models/category_models.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:http/http.dart' as http;

final _URL_NEWS = 'https://newsapi.org/v2';
final _API_KEYS = 'dfacd68fc1c84a738454cbec4db99d96';


class NewsService with ChangeNotifier{
  List<Article> headLines = [];

  String _selectedCategory = 'business';
  List<Category> categories = [
    Category( FontAwesomeIcons.building, 'business' ),
    Category( FontAwesomeIcons.tv, 'entertainment' ),
    Category( FontAwesomeIcons.addressCard, 'general' ),
    Category( FontAwesomeIcons.headSideVirus, 'health' ),
    Category( FontAwesomeIcons.vials, 'science' ),
    Category( FontAwesomeIcons.futbol, 'sports' ),
    Category( FontAwesomeIcons.building, 'technology' )

  ];

  Map<String, List<Article>> categoryArticles = {
    
  };

// business entertainment general health science sports technology
  NewsService(){
    this.getTopHeadLines();
    categories.forEach((item){
      this.categoryArticles[item.name] = new List();
    });
    this.getArticlesByCategory(_selectedCategory);
  }

  get selectedCategory => this._selectedCategory;
  set selectedCategory(String valor) {
    this._selectedCategory = valor;
    this.getArticlesByCategory(valor);
    notifyListeners();
  }

  List<Article> get getArticulosCategoriaSeleccionada =>  this.categoryArticles[this.selectedCategory];

  getTopHeadLines() async {
    final url = '$_URL_NEWS/top-headlines?country=mx&page=0&apiKey=$_API_KEYS';
    final resp = await http.get(url);

    final newResponse  = newsResponseFromJson(resp.body);

    this.headLines.addAll(newResponse.articles);
    notifyListeners();
  }

  getArticlesByCategory(String category) async {

    if(this.categoryArticles[category].length > 0){
      return this.categoryArticles[category];
    }
      final url = '$_URL_NEWS/top-headlines?country=mx&page=0&apiKey=$_API_KEYS&category=$category';
      final resp = await http.get(url);

      final newResponse  = newsResponseFromJson(resp.body);

      this.categoryArticles[category].addAll(newResponse.articles);
      notifyListeners();
  }


}