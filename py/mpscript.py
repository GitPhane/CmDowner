import os
from pytube import YouTube

# Get the absolute path of the current script
script_path = os.path.abspath(__file__)

# Construct the path to the parent directory of the script
parent_dir = os.path.dirname(script_path)

# Construct the default path to the downloads directory
default_downloads_dir = os.path.join(parent_dir, '..', 'downloads', 'youtube', 'music')

# Prompt the user for the URL of the video to download
print("NOTE: Downloading duplicates will result in a mp4 file and an mp3 file")
video_url = input("Enter the URL of the video you want to download: ")

# Prompt the user for the download directory, defaulting to the default directory if no input is provided
download_dir = input(f"Enter the directory to download to (default: {default_downloads_dir}): ") or default_downloads_dir

# Make sure the download directory exists
os.makedirs(download_dir, exist_ok=True)

# Download the video to the download directory
yt = YouTube(video_url)
video = yt.streams.filter(only_audio=True).first()
out_file = video.download(output_path=download_dir)
base, ext = os.path.splitext(out_file)
new_file = base + '.mp3'
os.rename(out_file, new_file)
print(yt.title + " downloaded!")
