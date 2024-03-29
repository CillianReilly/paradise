# paradise
* Interactive:		$PHOME/paradisectl.sh
* Non-interactive:	$PHOME/paradisectl.sh start
* Test:			$PHOME/test.sh

Specify PHOME in your .bashrc or equivalent

##### Parameters
* cli - specify if kdb+ is ran in foreground or background. Default 0
* mic - specify to start mic. Default 1
* ml - use machine learning model to predict commands. Default 1

##### Requirements
* kdb+ 3.5+ https://code.kx.com/q
* Scripts from the qtools repository: https://github.com/CillianReilly/qtools 
* Python 3.5+ https://www.python.org
* embedPy: https://code.kx.com/q/ml/embedpy
* gTTS https://pypi.org/project/gTTS
* SpeechRecognition https://pypi.org/project/SpeechRecognition
##### Calendar
* Add reminders to calendar/reminders.csv
* Freq is either Y(early), M(onthly), W(eekly) or O(nce off)
##### Spotify
* Docs: https://developer.spotify.com/documentation/web-api
* IDs available at: https://developer.spotify.com/dashboard/login
* Authorization: https://developer.spotify.com/documentation/general/guides/authorization-guide
* Configure userID, ID, secretID, refreshToken and auth64 in spotify/cfg.q
##### Weather
* Dark Sky docs: https://darksky.net/dev/docs
* OpenCage docs: https://opencagedata.com/api
* Configure API keys in weather/cfg.q
##### Wolfram|Alpha
* Docs: https://products.wolframalpha.com/api/
* Configure App ID in wolfram/cfg.q
