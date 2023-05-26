import os
import yt_dlp

# Get the absolute path of the current script
script_path = os.path.abspath(__file__)

# Construct the path to the parent directory of the script
parent_dir = os.path.dirname(script_path)

# Construct the default path to the downloads directory
default_downloads_dir = os.path.join(parent_dir, '..', 'downloads', 'youtube', 'music')

# Prompt the user for the URL of the video to download
print("If you have list in your link, you will need to remove it. ")
video_url = input("Enter the URL of the video you want to download: ")

# Prompt the user for the download directory, defaulting to the default directory if no input is provided
download_dir = input(f"Enter the directory to download to (default: {default_downloads_dir}): ") or default_downloads_dir

# Make sure the download directory exists
os.makedirs(download_dir, exist_ok=True)

# Download the audio of the video to the download directory
ydl_opts = {'outtmpl': os.path.join(download_dir, '%(title)s.%(ext)s'), 'format': 'bestaudio/best', 'postprocessors': [{'key': 'FFmpegExtractAudio', 'preferredcodec': 'mp3', 'preferredquality': '192'}]}
with yt_dlp.YoutubeDL(ydl_opts) as ydl:
    info_dict = ydl.extract_info(video_url, download=True)
    audio_filename = ydl.prepare_filename(info_dict)

print(info_dict['title'] + " downloaded!")
