import os
import shutil

blank_ybn = './blank.ybn'
ybn_output_dir = './stream/ybn'
ybn_paths = './ybn_paths.txt'
ybn_list = './ybn_list.txt'

blank_ynd = './blank.ynd'
ynd_output_dir = './stream/ynd'
ynd_paths = './ynd_paths.txt'
ynd_list = './ynd_list.txt'

blank_ymap = './blank.ymap'
ymap_output_dir = './stream/ymap'
ymap_paths = './ymap_paths.txt'
ymap_list = './ymap_list.txt'

def clean_list(input_paths_file, output_list_file):
    if not os.path.exists(input_paths_file):
        print(f"Error: Could not find '{input_paths_file}'")
        return

    cleaned_names = []
    skipped_count = 0

    try:
        with open(input_paths_file, 'r', encoding='utf-8') as f:
            for line in f:
                line = line.strip()
                if line:
                    if line.startswith('--'):
                        skipped_count += 1
                        continue

                    name = os.path.basename(line)
                    cleaned_names.append(name)

        unique_names = sorted(list(set(cleaned_names)))

        with open(output_list_file, 'w', encoding='utf-8') as f:
            for name in unique_names:
                f.write(f"{name}\n")

        print(f"Saved {len(unique_names)} file names to: {output_list_file}")
        if skipped_count > 0:
            print(f"Skipped {skipped_count} lines starting with '--'")

    except Exception as e:
        print(f"Error: {e}")


def generate_blank_files(list_file, blank_template, output_dir):
    if not os.path.exists(list_file):
        print(f"Error: Could not find '{list_file}'.")
        return
    
    if not os.path.exists(blank_template):
        print(f"Error: Could not find '{blank_template}'.")
        return

    os.makedirs(output_dir, exist_ok=True)

    count = 0

    try:
        with open(list_file, 'r', encoding='utf-8') as f:
            for line in f:
                file_name = line.strip()
                
                if not file_name:
                    continue
                    
                new_file_path = os.path.join(output_dir, file_name)
                
                shutil.copy2(blank_template, new_file_path)
                count += 1

    except Exception as e:
        print(f"Error: {e}")

    return count

if __name__ == "__main__":
    clean_list(ybn_paths, ybn_list)
    ybn_count = generate_blank_files(ybn_list, blank_ybn, ybn_output_dir)
    print(f"Generated {ybn_count} blank YBN files in '{ybn_output_dir}'\n")

    clean_list(ynd_paths, ynd_list)
    ynd_count = generate_blank_files(ynd_list, blank_ynd, ynd_output_dir)
    print(f"Generated {ynd_count} blank YND files in '{ynd_output_dir}'")

    clean_list(ymap_paths, ymap_list)
    ymap_count = generate_blank_files(ymap_list, blank_ymap, ymap_output_dir)
    print(f"Generated {ymap_count} blank YMAP files in '{ymap_output_dir}'")