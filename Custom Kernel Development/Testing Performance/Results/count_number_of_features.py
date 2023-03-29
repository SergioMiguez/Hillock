import os

filename = "..\\..\\.config_v50_final"  # Relative path to file

if os.path.isfile(filename):  # Check if file exists
    count = 0

    with open(filename, 'r') as file:
        for line in file:
            # Check if line starts with "#" or is empty
            if not line.startswith("#") and line.strip():
                count += 1

    print("Number of non-empty and non-commented lines in the file:", count)
    
else:
    print(f"Error: {filename} does not exist.")
