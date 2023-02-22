
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/models/category_list.dart';
import 'package:restaurant/services/database.dart';
import 'package:restaurant/services/firebase.dart';
import 'package:restaurant/shared/loading.dart';
import 'menu_page.dart';


class CategoryPage extends StatefulWidget {
  DatabaseService databaseService;
  CategoryPage({super.key, required this.databaseService});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context){
    final user = Provider.of<User>(context);
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/background.jpeg'),
        ),
      ),
      child: FutureBuilder(
        future: widget.databaseService.getCategoryList(),
        builder: (context, snapshot) {
          if (snapshot.hasError){
            return Text('No data was found !! ${snapshot.error}', style: TextStyle(color: Colors.white),);
          }
          else if (snapshot.hasData) {
            var categories = snapshot.data!;
            return ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
              return SizedBox(
                height: 200,
                child: InkWell(
                  onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MenuPage(products_list: categories[index].product_list, uid: user.uid, databaseService : widget.databaseService),
                          ),
                        );
                    },
                  child: Card(
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(categories[index].image_url),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          categories[index].name, 
                          style: (
                            const TextStyle(
                              fontSize: 45,
                              color: Colors.white,
                            )
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
              }
            );  
          }
          else {
            return Loading();
          }
        },
      ),
    );
  }
}




/*
return ListView.builder(
      itemCount: foodList == null ? 0 : foodList.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Description(uid: user.uid,food: foodList[index]),
                ),
              );
          },
          child : Card(
            margin: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(foodList[index].image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    foodList[index].name,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
    },
  );
*/