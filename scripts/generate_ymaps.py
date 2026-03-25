import os
import shutil

blank_file = './blank.ymap'   
ymap_output_dir = '../stream/ymap'       

ymap_paths = './ymap_paths.txt'
ymap_list = './ymap_list.txt'

def clean_ymap_list():
    if not os.path.exists(ymap_paths):
        print(f"Error: Could not find '{ymap_paths}'")
        return

    cleaned_names = []

    try:
        with open(ymap_paths, 'r', encoding='utf-8') as f:
            for line in f:
                line = line.strip()
                if line:
                    name = os.path.basename(line)
                    cleaned_names.append(name)

        unique_names = sorted(list(set(cleaned_names)))

        with open(ymap_list, 'w', encoding='utf-8') as f:
            for name in unique_names:
                f.write(f"{name}\n")

        print(f"Saved {len(unique_names)} unique ymap names to: {ymap_list}")

    except Exception as e:
        print(f"An error occurred: {e}")


def generate_blank_ymaps():
    if not os.path.exists(ymap_list):
        print(f"Error: Could not find '{ymap_list}'.")
        return
    
    if not os.path.exists(blank_file):
        print(f"Error: Could not find '{blank_file}'.")
        return

    os.makedirs(ymap_output_dir, exist_ok=True)

    count = 0
    try:
        with open(ymap_list, 'r', encoding='utf-8') as f:
            for line in f:
                file_name = line.strip()
                
                if not file_name:
                    continue
                    
                if not file_name.lower().endswith('.ymap'):
                    file_name += '.ymap'
                    
                new_file_path = os.path.join(ymap_output_dir, file_name)
                
                shutil.copy2(blank_file, new_file_path)
                count += 1
                
        print(f"Generated {count} blank YMAP files in '{ymap_output_dir}'")
        
    except Exception as e:
        print(f"An error occurred: {e}")

if __name__ == "__main__":
    clean_ymap_list()
    generate_blank_ymaps()