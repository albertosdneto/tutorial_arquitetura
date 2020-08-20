import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tutorial_arquitetura/modules/search/presenter/search/search_bloc.dart';
import 'package:tutorial_arquitetura/modules/search/presenter/search/states/states.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final bloc = Modular.get<SearchBloc>();

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Github Search"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
            child: TextField(
              onChanged: bloc.add,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Search",
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
                stream: bloc,
                builder: (context, snapshot) {
                  final state = bloc.state;
                  if (state is SearchStart) {
                    return Center(
                      child: Text('Digite um texto'),
                    );
                  }

                  if (state is SearchError) {
                    return Center(
                      child: Text('=/'),
                    );
                  }

                  if (state is SearchLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final list = (state as SearchSuccess).list;

                  return ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (_, id) {
                        final item = list[id];
                        return ListTile(
                          leading: item.image == null
                              ? SizedBox(width: 20.0, child: Container())
                              : CircleAvatar(
                                  backgroundImage: NetworkImage(item.image),
                                ),
                          title: Text(item.name ?? "nada aqui"),
                          subtitle: Text(item.url ?? ""),
                        );
                      });
                }),
          )
        ],
      ),
    );
  }
}
