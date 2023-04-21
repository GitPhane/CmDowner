import os
import yt_dlp

# Get the absolute path of the current script
script_path = os.path.abspath(__file__)

# Construct the path to the parent directory of the script
parent_dir = os.path.dirname(script_path)

# Construct the default path to the downloads directory
default_downloads_dir = os.path.join(parent_dir, '..', 'downloads', 'youtube', 'videos')

# Prompt the user for the URL of the video to download
video_url = input("Enter the URL of the video you want to download: ")

# Prompt the user for the download directory, defaulting to the default directory if no input is provided
download_dir = input(f"Enter the directory to download to (default: {default_downloads_dir}): ") or default_downloads_dir

# Make sure the download directory exists
os.makedirs(download_dir, exist_ok=True)

# Download the video and audio streams to the download directory
ydl_opts = {'outtmpl': os.path.join(download_dir, '%(title)s.%(ext)s'), 'merge_output_format': 'mp4', 'format': 'bestvideo[height<=2160][ext=mp4]+bestaudio[ext=m4a]/best[height<=2160]/best'}
with yt_dlp.YoutubeDL(ydl_opts) as ydl:
    ydl.download([video_url])
    
print("Download complete!")
