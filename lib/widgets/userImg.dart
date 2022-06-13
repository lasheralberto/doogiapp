import 'package:ebook/widgets/ContainerPickSingleImage.dart';
import 'package:ebook/widgets/DogsAdoptionList.dart';
import 'package:ebook/widgets/big_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class UserImgProfile extends StatefulWidget {
  var usermail;
  var countdogis;

  UserImgProfile({Key? key, required this.usermail, this.countdogis})
      : super(key: key);

  @override
  State<UserImgProfile> createState() => _UserImgProfileState();
}

class _UserImgProfileState extends State<UserImgProfile> {

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white70,
      elevation: 10,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SimpleImagePicker()));
            },
            child: FutureBuilder<List<ParseObject>>(
              future: getUserImg(widget.usermail),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return const Center(
                      child: SizedBox(
                          width: 100,
                          height: 100,
                          child: CircularProgressIndicator()),
                    );
                  default:
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text("Error..."),
                      );
                    }
                    if (snapshot.data!.isNotEmpty) {
                      final varUserImg = snapshot.data![0];
                      final varImg = varUserImg.get<ParseFileBase>('UserImage');
                      return CircleAvatar(
                        backgroundColor: Colors.white70,
                        minRadius: 60.0,
                        child: CircleAvatar(
                            radius: 80.0,
                            backgroundImage:
                                NetworkImage(varImg!.url.toString())),
                      );
                    } else {
                      return const CircleAvatar(
                        backgroundColor: Colors.white70,
                        minRadius: 60.0,
                        child: CircleAvatar(
                            radius: 80.0,
                            backgroundImage: NetworkImage(
                                'https://ik.imagekit.io/aml28/Google_Contacts_icon.svg_O1-1-E_wH.png?ik-sdk-version=javascript-1.4.3&updatedAt=1654901242362')),
                      );
                    }
                }
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            
            children: [
              SizedBox(width: 20,),
              FutureBuilder<List<ParseObject>>(
                  future: getCountDogs2(widget.usermail),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return const Center(
                          child: SizedBox(
                              width: 100,
                              height: 100,
                              child: CircularProgressIndicator()),
                        );
                      default:
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text("Error..."),
                          );
                        }
                        if (!snapshot.hasData) {
                          return Text('0');
                        } else {
                          
                          return Text(snapshot.data!.length.toString());
                        }
                    }
                  }),
              SizedBox(width: 20,),
              BigText(text: widget.usermail),
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class UserDogList extends StatefulWidget {
  var usermail;

  UserDogList({
    Key? key,
    required this.usermail,
  }) : super(key: key);

  @override
  State<UserDogList> createState() => _UserDogListState();
}

class _UserDogListState extends State<UserDogList> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder<List<ParseObject>>(
          future: getTodo(widget.usermail),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: SizedBox(
                      width: 100,
                      height: 100,
                      child: const CircularProgressIndicator()),
                );
              default:
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Error..."),
                  );
                }
                if (!snapshot.hasData) {
                  return const Center(
                    child: Text("No Data..."),
                  );
                } else {
                  return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(top: 10.0, bottom: 20),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        //*************************************
                        //Get Parse Object Values
                        final varTodo = snapshot.data![index];
                        final varTitle = varTodo.get<String>('title')!;
                        final varBreed = varTodo.get<String>('Breed');
                        final varImg = varTodo.get<ParseFileBase>('DogImg')!;

                        //*************************************

                        return ListTile(
                          title: Text(varTitle),
                          subtitle: Text(varBreed as String),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            child: Image.network(varImg.url as String),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.blue,
                                ),
                                onPressed: () async {
                                  await deleteTodo(varTodo.objectId!);
                                  setState(() {
                                    final snackBar = SnackBar(
                                      content: Text("Dog removed!"),
                                      duration: Duration(seconds: 1),
                                    );
                                    ScaffoldMessenger.of(context)
                                      ..removeCurrentSnackBar()
                                      ..showSnackBar(snackBar);
                                  });
                                },
                              )
                            ],
                          ),
                        );
                      });
                }
            }
          },
        ),
      ],
    );
  }
}

Future<Object> getCountDogs(usermail) async {
  await Future.delayed(Duration(seconds: 2), () {});

  QueryBuilder<ParseObject> queryTodo =
      QueryBuilder<ParseObject>(ParseObject('Todo'));

  queryTodo.whereEqualTo('UserMail', usermail);
  var countdogs = queryTodo.count();

  final ParseResponse apiResponse = await queryTodo.query();

  if (apiResponse.success && apiResponse.results != null) {
    return countdogs;
  } else {
    return [];
  }
}

Future<List<ParseObject>> getCountDogs2(usermail) async {
  await Future.delayed(Duration(seconds: 2), () {});

  QueryBuilder<ParseObject> queryTodo =
      QueryBuilder<ParseObject>(ParseObject('Todo'));

  queryTodo.whereEqualTo('UserMail', usermail);

  final ParseResponse apiResponse = await queryTodo.query();

  if (apiResponse.success && apiResponse.results != null) {
    return apiResponse.results as List<ParseObject>;
  } else {
    return [];
  }
}
