import 'package:comedy/feacture/my_saved/data/model/my_saved_model.dart';
import 'package:flutter/material.dart';

class Search extends SearchDelegate {

  final List<MySavedModel> mySavedList;
  MySavedModel selectedResult;

  Search({this.mySavedList,});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => Navigator.pop(context),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text(selectedResult.title),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    List<MySavedModel> suggestionList = [];

    if(query.isNotEmpty){
      suggestionList.addAll(mySavedList.where((element) => element.title.contains(query) || element.answer.contains(query)));
    }

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (_,index){
        return ListTile(
          title: Text(suggestionList[index].title),
          onTap: (){
            selectedResult = suggestionList[index];
            showResults(context);
          },
        );
      },
    );
  }

}