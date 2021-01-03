import os
import gtts
import speech_recognition as sr

recognizer=sr.Recognizer()
microphone=sr.Microphone()

def listen(recognizer,input):
	with input as source:
		recognizer.adjust_for_ambient_noise(source,duration=0.5)
		return recognizer.listen(source)

def mic():
	audio=listen(recognizer,microphone)
	return recognizer.recognize_google(audio)

def speak(text):
	s=gtts.gTTS(text)
	s.save("speech.wav")
	os.system("omxplayer --no-keys speech.wav >/dev/null 2>&1")