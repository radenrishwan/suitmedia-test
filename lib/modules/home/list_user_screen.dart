import 'package:flutter/material.dart';
import 'package:magang/helper/contant.dart';
import 'package:magang/modules/home/provider/user_provider.dart';
import 'package:provider/provider.dart';

class ListUserScreen extends StatefulWidget {
  const ListUserScreen({super.key});

  @override
  State<ListUserScreen> createState() => _ListUserScreenState();
}

class _ListUserScreenState extends State<ListUserScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent == _scrollController.position.pixels) {
        context.read<UserProvider>().loadMore().then((value) {
          if (value > 0) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Getting more user...')));
          }
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Third Screen'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.3,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: FutureBuilder(
          future: context.read<UserProvider>().fetchUsers(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }

            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Consumer<UserProvider>(
              builder: (context, value, child) {
                return RefreshIndicator(
                  onRefresh: () async {
                    value.users.clear();
                    value.page = 1;
                    await value.fetchUsers();
                  },
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: value.users.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding.left, vertical: 16),
                        child: ListTile(
                          title: Text('${value.users[index].firstName} ${value.users[index].lastName}'),
                          subtitle: Text(value.users[index].email),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(value.users[index].avatar),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
