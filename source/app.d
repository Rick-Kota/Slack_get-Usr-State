import std.stdio;
import std.net.curl;
import std.json,  std.file;
import std.conv : to;

immutable auto _User_listurl = "https://slack.com/api/users.list";

string get_token()
{
	auto content = to!string(read("Setting.json"));
	JSONValue[string] setting = parseJSON(content).object;
	string data = setting["token"].str;
	return data;
}

void get_List()
{
	const auto _token = get_token(); 
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

		_Data["Person"].array[0] =  presonObj.array;

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
