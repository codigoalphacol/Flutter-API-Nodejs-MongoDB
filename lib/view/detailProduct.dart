
import 'package:appnode/controllers/databasehelpers.dart';
import 'package:appnode/view/editProduct.dart';
import 'package:appnode/view/listProducts.dart';
import 'package:flutter/material.dart';

class Detail extends StatefulWidget {

  List list;
  int index;
  Detail({this.index,this.list});

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {


  DataBaseHelper databaseHelper = new DataBaseHelper();

  //create function delete 
  void confirm (){
  AlertDialog alertDialog = new AlertDialog(
    content: new Text("Esta seguto de eliminar '${widget.list[widget.index]['name']}'"),
    actions: <Widget>[
      new RaisedButton(
        child: new Text("OK remove!",style: new TextStyle(color: Colors.black),),
        color: Colors.red,
        onPressed: (){
                      databaseHelper.removeRegister(widget.list[widget.index]['_id'].toString());
                      Navigator.of(context).push(
                          new MaterialPageRoute(
                            builder: (BuildContext context) => new ListProducts(),
                          )
                      );
                    },
      ),
      new RaisedButton(
        child: new Text("CANCEL",style: new TextStyle(color: Colors.black)),
        color: Colors.green,
        onPressed: ()=> Navigator.pop(context),
      ),
    ],
  );

  showDialog(context: context, child: alertDialog);
}


  @override
  Widget build(BuildContext context) {
     return new Scaffold(
      appBar: new AppBar(title: new Text("${widget.list[widget.index]['name']}")),
      body: new Container(
        height: 270.0, 
        padding: const EdgeInsets.all(20.0),
        child: new Card(
          child: new Center(
            child: new Column(
              children: <Widget>[
                new Padding(padding: const EdgeInsets.only(top: 30.0),),
                new Text(widget.list[widget.index]['name'], style: new TextStyle(fontSize: 20.0),),
                Divider(),
                new Text("Price : ${widget.list[widget.index]['price']}", style: new TextStyle(fontSize: 18.0),),
                new Padding(padding: const EdgeInsets.only(top: 30.0),),

                new Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new RaisedButton(
                    child: new Text("Edit"),                  
                    color: Colors.blueAccent,
                    shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                    onPressed: ()=>Navigator.of(context).push(
                        new MaterialPageRoute(
                          builder: (BuildContext context)=>new EditProduct(list: widget.list, index: widget.index,),
                        )
                      ),                    
                  ),
                  VerticalDivider(),
                  new RaisedButton(
                    child: new Text("Delete"),                  
                    color: Colors.redAccent,
                    shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                    onPressed: ()=>confirm(),                
                  ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}