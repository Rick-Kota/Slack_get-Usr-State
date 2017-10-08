import std.stdio;
import std.net.curl;
import std.json,  std.file;
import std.conv : to;

immutable auto _User_listurl = "_____";
immutable auto _token = "_____";

void get_List()
{
	//JSONValue list = parseJSON(post(_User_listurl,[ "token": _token ]));
	//JSONValue presonObj = [
	//    "id" : list["members"][num]["id"],
	//    "word" : "status_text" !in list["members"][num]["profile"] ? parseJSON("null") :list["members"][num]["profile"]["status_text"],
	//    "is_bot" : list["members"][num]["is_bot"]
	//];
	//writeln(presonObj);
	JSONValue list = parseJSON(post(_User_listurl,[ "token": _token ]));
	JSONValue _Data;
	foreach( test ; 0 .. list["members"].array.length - 1 )
	{
		JSONValue presonObj = [
		    "id" : list["members"][test]["id"],
		    "name" : list["members"][test]["name"],
		    "word" : "status_text" !in list["members"][test]["profile"] ? parseJSON("null") :list["members"][test]["profile"]["status_text"],
		    "is_bot" : list["members"][test]["is_bot"]
		];
		writeln(toJSON(presonObj));

		_Data["Person"][0] =  [toJSON(presonObj)];

	}
	writeln(_Data);

//	}
}

/*
enum JSONValue _P_Status = get_List()
*/

void main()
{
	get_List();
}
