import 'package:flutter/material.dart';
import 'package:shop_app/modules/on_boarding_screen.dart';

class BoardingModel
{
  final String image;
  final String title;
  final String body;

    BoardingModel ({
   required this.image,
   required this.title,
   required this.body,
});
}
List<BoardingModel> boarding =[
  BoardingModel(
    image: 'assets/images/1234.jpg',
    title: 'On Board 1 Title ',
    body: 'On Board 1 Body',
  ),
  BoardingModel(
image: 'assets/images/1234.jpg',
  title: 'On Board 2 Title ',
  body: 'On Board 2 Body',
),
  BoardingModel(
    image: 'assets/images/1234.jpg',
    title: 'On Board 3 Title ',
    body: 'On Board 3 Body',
  ),
];
class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) => buildBoardingItem(boarding[index]),
                itemCount: boarding.length ,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                Text('Indecator',
                ),
                Spacer(),
                FloatingActionButton(onPressed: (){},
                child: Icon(Icons.arrow_forward_ios),),
              ],
            ),


          ],
        ),
      ) ,
    );
  }
  Widget buildBoardingItem(BoardingModel model) => Column (
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
          child: Image(image: AssetImage('${model.image}'),
          ),
      ),

      Text(
        '${model.title}',
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
        height: 15.0,
      ),
      Text(
        '${model.body}',
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
        height: 15.0,
      ),
    ],
  );
}
