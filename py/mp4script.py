from pytube import YouTube
import os

# Get the video URL from the user
url = input("Enter the URL of the video you want to download: ")

# Create a YouTube object
yt = YouTube(url)

# Get available video streams
streams = yt.streams.filter(progressive=True, file_extension='mp4')

# Display available resolutions to the user
print("Available Resolutions:")
for i, stream in enumerate(streams):
    print(f"{i+1}. {stream.resolution}")

# Ask the user to choose a resolution
while True:
    choice = int(input("Enter the number of the desired resolution: "))
    if 1 <= choice <= len(streams):
        break
    else:
        print("Invalid choice. Please enter a number between 1 and", len(streams))

# Get the selected stream and resolution
stream = streams[choice - 1]

# Get the destination folder from the user
destination = input("Enter the destination folder (leave blank for current directory): ") or '.'

# Download the video
stream.download(output_path=destination)

# Print success message
print(f"\n{yt.title} has been successfully downloaded to {os.path.abspath(destination)}")
