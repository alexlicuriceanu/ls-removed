import os

input_file = 'ymap_paths.txt'    # The file with the aabsolute paths extracted from CodeWalker
output_file = 'ymap_list.txt'   # The clean file for the generator script

def clean_ymap_list():
    if not os.path.exists(input_file):
        print(f"Error: Could not find '{input_file}'")
        return

    cleaned_names = []

    try:
        with open(input_file, 'r', encoding='utf-8') as f:
            for line in f:
                line = line.strip()
                if line:
                    # os.path.basename extracts 'filename.ymap' from the full path
                    name = os.path.basename(line)
                    cleaned_names.append(name)

        # Remove duplicates and sort (optional but recommended)
        unique_names = sorted(list(set(cleaned_names)))

        with open(output_file, 'w', encoding='utf-8') as f:
            for name in unique_names:
                f.write(f"{name}\n")

        print(f"Success! Cleaned {len(unique_names)} unique ymap names.")
        print(f"Saved to: {output_file}")

    except Exception as e:
        print(f"An error occurred: {e}")

if __name__ == "__main__":
    clean_ymap_list()