from pytube import YouTube
import os
import time

print("Please note that if there are any duplicates, program will crash!")
print("Enter the directory:")
destination = str(input(">> ")) or '.'  
yt = YouTube(
    str(input("Enter the URL of the video you want to download: \n>> ")))
video = yt.streams.filter(only_audio=True).first()
out_file = video.download(output_path=destination)
base, ext = os.path.splitext(out_file)
new_file = base + '.mp3'
os.rename(out_file, new_file)
print(yt.title + " downloaded!")

print("Exiting in 3")
time.sleep(1)
print("Exiting in 2")
time.sleep(1)
print("Exiting in 1")
time.sleep(1)
