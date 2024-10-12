// https://developer.spotify.com/documentation/web-api
// Contains user specific details

cfg:(!). flip(
	(`userID;"");
	(`ID;"");
	(`secretID;"");
	(`refreshToken;"");
	(`auth64;"base64 encode <ID>:<secretID>");
	(`url;`:https://api.spotify.com);
	(`tokenUrl;`:https://accounts.spotify.com)
	)
