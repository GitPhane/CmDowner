import urllib.request
import os
import urllib.error
import sys

url = input("Enter the download URL: ")
filename = url.split("/")[-1]

# ask user to choose download directory
dir_path = input("Enter download directory (leave blank for default): ")
if not dir_path:
    dir_path = "../downloads/files"

# create directory if it doesn't exist
if not os.path.exists(dir_path):
    os.makedirs(dir_path)

filepath = os.path.join(dir_path, filename)

# download the file
urllib.request.urlretrieve(url, filepath)
print("File downloaded successfully!")

