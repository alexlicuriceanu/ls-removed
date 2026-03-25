import os
import shutil

# --- Configuration ---
# Change these names if your files are named differently
list_file = 'test.txt' 
blank_file = 'blank.ymap'   
output_dir = 'stream'       

def generate_blank_ymaps():
    # 1. Safety checks to ensure your files are in the right place
    if not os.path.exists(list_file):
        print(f"Error: Could not find '{list_file}'. Make sure it is in the same folder.")
        return
    
    if not os.path.exists(blank_file):
        print(f"Error: Could not find '{blank_file}'. Make sure it is in the same folder.")
        return

    # 2. Create the 'stream' folder if it doesn't exist yet
    os.makedirs(output_dir, exist_ok=True)

    count = 0
    # 3. Read the text file and start cloning
    try:
        with open(list_file, 'r', encoding='utf-8') as f:
            for line in f:
                # Clean up the line (removes invisible spaces or newlines)
                file_name = line.strip()
                
                # Skip any accidental empty lines in your text file
                if not file_name:
                    continue
                    
                # Force the .ymap extension just in case your list doesn't have it
                if not file_name.lower().endswith('.ymap'):
                    file_name += '.ymap'
                    
                # Create the path for the new file inside the stream folder
                new_file_path = os.path.join(output_dir, file_name)
                
                # Copy the master blank file and rename it
                shutil.copy2(blank_file, new_file_path)
                count += 1
                
        print(f"Success! Generated {count} blank YMAP files in the '{output_dir}' folder.")
        
    except Exception as e:
        print(f"An error occurred: {e}")

if __name__ == "__main__":
    generate_blank_ymaps()