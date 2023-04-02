import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_design/models/newproduct.dart';

class Productdetails extends StatefulWidget {
 final Products products; 
 final List<Products>? allProducts;
   Productdetails({Key? key, required this.products,required this.allProducts
  }) : super(key: key);

  @override
  State<Productdetails> createState() => _ProductdetailsState();
}

class _ProductdetailsState extends State<Productdetails> {
  String image = "";
  List<Products> similarProducts = [];
  List<String> images = [];
  var _current = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    image = "${widget.products.image}";
    images.add(image);
    print("object4${widget.allProducts}");
    widget.allProducts?.forEach((element) {
      if (element.category == widget.products.category) {
        similarProducts?.add(element);
      }
    });
    print("object2 ${similarProducts}");
    print("object inisde ${widget.products.category}");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios, color: Colors.black,)),
          title: Text('Product Details', style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold),),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.share, color: Colors.black,),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  CarouselSlider(
                    items: images.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return GestureDetector(
                            onTap: () {},
                            child: Container(
                                child: Image.network(i)),
                          );
                        },
                      );
                    }).toList(),
                    options: CarouselOptions(
                        autoPlay: true,
                        viewportFraction: 1.0,
                        enlargeCenterPage: false,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }),
                  ),
                  Positioned.directional(
                    textDirection: Directionality.of(context),
                    end: 20.0,
                    bottom: 0.0,
                    child: Row(
                      children: images.map((i) {
                        int index = images.indexOf(i);
                        return Container(
                          width: 6.0,
                          height: 6.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _current == index
                                ? Theme
                                .of(context)
                                .primaryColorLight
                            /*.withOpacity(0.9)*/
                                : Theme
                                .of(context)
                                .hintColor,
                          ),
                        );
                      }).toList(),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text("${widget.products.title}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)),
                    Text("\$${widget.products.price}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.indigoAccent),),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Rating  4.5",
                          style: Theme
                              .of(context)
                              .textTheme
                              .subtitle1,
                        ),
                        Icon(Icons.star,size: 20,)
                      ],
                    ),
                    SizedBox(height: 20,),
                    Text("${widget.products.description}....ReadMore",
                      style: Theme
                          .of(context)
                          .textTheme
                          .subtitle1,
                    ),

                  ],
                ),
              ),
              SizedBox(height: 20,),

              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Text("Similar Product",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  Icon(Icons.arrow_forward_ios_outlined)
                ],),
              ),
              SizedBox(height: 20,),

              Container(
                height: 290,
                width: double.infinity,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: similarProducts?.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 220,
                      child: Card(
                        margin: EdgeInsets.all(5),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        elevation: 5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Image.network(
                                  "${similarProducts![index].image}",height: 150,),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("${similarProducts![index].title}",style: TextStyle(fontWeight: FontWeight.w400),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("\$${similarProducts![index].price}",style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold )),
                            )

                          ],
                        ),
                      ),
                    );
                  },

                ),
              ),
              SizedBox(height: 60,),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                elevation: 20,
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  contentPadding: EdgeInsets.symmetric(vertical: 5),
                  tileColor: Colors.indigoAccent,
                  title: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Center(
                      child: Text(
                        'Add To Cart',
                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}