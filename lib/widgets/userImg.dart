import 'package:ebook/widgets/ContainerPickSingleImage.dart';
import 'package:ebook/widgets/DogsAdoptionList.dart';
import 'package:ebook/widgets/big_text.dart';
import 'package:ebook/widgets/personalDogDetail.dart';
import 'package:ebook/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
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
    return Container(
      color: Colors.blue,
      width: MediaQuery.of(context).size.width / 1.2,
      height: MediaQuery.of(context).size.width / 1.6,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        color: Colors.white,
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.only(right: 10, left: 10),
          child: Column(
            children: [
              SmallText(text: widget.usermail),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SimpleImagePicker()));
                },
                child: FutureBuilder<List<ParseObject>>(
                  future: getUserImg(widget.usermail),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return const Center(
                          child: GFLoader(),
                        );
                      default:
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text("Error..."),
                          );
                        }
                        if (snapshot.data!.isNotEmpty) {
                          final varUserImg = snapshot.data![0];
                          final varImg =
                              varUserImg.get<ParseFileBase>('UserImage');
                          return Container(
                            decoration:
                                const BoxDecoration(shape: BoxShape.circle),
                            child: CircleAvatar(
                                radius: 60.0,
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
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(width: MediaQuery.of(context).size.width/4,),
                  FutureBuilder<List<ParseObject>>(
                      future: getCountDogs2(widget.usermail),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return const Center(
                              child: GFLoader(),
                            );
                          default:
                            if (snapshot.hasError) {
                              return const Center(
                                child: Text("Error..."),
                              );
                            }
                            if (!snapshot.hasData) {
                              return const Text('0');
                            } else {
                              return Column(
                                children: [
                                  BigText(text: 'Dogs for adoption'),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  BigText(
                                      text: snapshot.data!.length.toString()),
                                ],
                              );
                            }
                        }
                      }),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
              const SizedBox(
                height: 0,
              ),
            ],
          ),
        ),
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
  final bool _isEnable =
      false; //_isEnable is the boolean variable and set it false, so we have to make it true when user tap on text

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        //borderRadius: BorderRadius.circular(300),
      ),
      child: Column(
        children: [
          FutureBuilder<List<ParseObject>>(
            future: getTodo(widget.usermail),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return const Center(
                    child: GFLoader(),
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
                        addAutomaticKeepAlives: false,
                        addRepaintBoundaries: false,
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
                          final varAge = varTodo.get<String>('Age');
                          final varDesc = varTodo.get<String>('DogDescription');
                          final varImg = varTodo.get<ParseFileBase>('DogImg')!;
                          final varLat = varTodo.get<double>('latitude');
                          final varLong = varTodo.get<double>('longitude');

                          //*************************************

                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 10,
                                  offset: Offset(0, 10),
                                ),
                              ],
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => personalDogDetail(
                                            screen: 'personal_detailForm',
                                            title: varTitle,
                                            Age: varAge as String,
                                            lat: varLat,
                                            long: varLong,
                                            description: varDesc,
                                            img: varImg.url,
                                            breed: varBreed)));
                              },
                              child: ListTile(
                                title: Text(varTitle),
                                subtitle: Text(varBreed as String),
                                leading: Container(
                                  
                                  decoration:
                                      const BoxDecoration(shape: BoxShape.circle),
                                  child: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(varImg.url as String),
                                  ),
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
                                          const snackBar = SnackBar(
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
                              ),
                            ),
                          );
                        });
                  }
              }
            },
          ),
        ],
      ),
    );
  }
}

Future<Object> getCountDogs(usermail) async {
  await Future.delayed(const Duration(seconds: 2), () {});

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
  await Future.delayed(const Duration(seconds: 2), () {});

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
