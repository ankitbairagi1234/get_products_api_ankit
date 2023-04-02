import 'dart:convert';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:dio/dio.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:ui_design/screens/productdetails.dart';
import '../models/newproduct.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();

}

class _ProductListState extends State<ProductList> {

  List<Products>? getproduct;

   ProductList() async {
      try {
        Dio dio = Dio();
             var request = await dio.get("https://fakestoreapi.com/products");
             if (request.statusCode == 200) {
           getproduct =  productsFromJson(jsonEncode(request.data));

               setState(() {

               });
             }
             else {
             print("failed to load data");
             }
      } on Exception catch (e) {
        print("$e");
      }
   }
   @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }
  @override
  void initState() {
    super.initState();
    ProductList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: Icon(Icons.arrow_back_ios,color: Colors.black,),
          title: Text('Product List',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.filter_list_alt,color: Colors.black,),
            )
          ],
        ),
        body: SingleChildScrollView(
            child: Container(
             child: getproduct == null || getproduct == "" ? Center(child: CircularProgressIndicator(),)
                 : Container(
                      height: MediaQuery.of(context).size.height*3.5,
                      child: StaggeredGridView.countBuilder(
                      staggeredTileBuilder:(index)=>StaggeredTile.fit(1.bitLength),
                      crossAxisCount: 2,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                     itemCount:  getproduct?.length,
                      itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (c)=>Productdetails(
                          products: getproduct![index],
                          allProducts: getproduct,
                        )));
                      },
                      child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c)=>Productdetails())),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child:  FavoriteButton(
                                iconSize: 40,
                                valueChanged:(_isFavorite) {
                                  print('Is Favorite $_isFavorite)');
                                },
                              ),
                            ),

                            Center(
                              child: FadedScaleAnimation(
                                  child: Image.network("${getproduct?[index].image}",height: 150,)
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("${getproduct?[index].title}",
                                style:TextStyle(fontWeight: FontWeight.w500,fontSize: 15)
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("\$${getproduct?[index].price}", style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black87)
                              ),
                            ),
                          ],
                        )

                      ),
                    );
                  },),
            ),
          ),
        ),
      ),
    );
  }
}
