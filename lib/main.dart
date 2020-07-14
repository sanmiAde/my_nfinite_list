import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_nfinite_list/data/local/PostModel.dart';
import 'package:my_nfinite_list/post/post_bloc.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Infinite Scroll',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Posts'),
        ),
        body: BlocProvider(
          create: (context) => PostBloc(PostInitial())..add(PostFetched()),
          child: HomePage(),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  PostBloc _postBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _postBloc = BlocProvider.of<PostBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        if (state is PostInitial) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is PostFailure) {
          return Center(
            child: Text('failed to fetch posts'),
          );
        }
        if (state is PostSuccess) {
          if (state.posts.isEmpty) {
            return Center(
              child: Text('no posts'),
            );
          }
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return index >= state.posts.length
                  ? BottomLoader()
                  : PostWidget(
                      postModel: state.posts[index],
                      onTap: () {
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                          builder: (context) =>
//                              Detail(postModel,: state.posts[index])),
//                    );
                        print(state.posts[index]);
                      });
            },
            itemCount: state.hasReachedMax
                ? state.posts.length
                : state.posts.length + 1,
            controller: _scrollController,
          );
        }
        return Container();
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _postBloc.add(PostFetched());
    }
  }
}

class Detail extends StatelessWidget {
  final PostModel postModel;
  Detail({this.postModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Column(
        children: <Widget>[
          Text("${postModel.title}"),
          Center(
            child: RaisedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Go back!'),
            ),
          ),
        ],
      ),
    );
  }
}

class SinglePost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }
}

class PostWidget extends StatelessWidget {
  final PostModel postModel;
  final Function onTap;

  const PostWidget({Key key, @required this.postModel, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        '${postModel.id}',
        style: TextStyle(fontSize: 10.0),
      ),
      title: Text(postModel.title),
      isThreeLine: true,
      subtitle: Text(postModel.body),
      dense: true,
      onTap: onTap,
    );
  }
}

class SimpleBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }
}
