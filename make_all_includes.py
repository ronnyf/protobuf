#!/usr/local/bin/python3

import os

file_set_names = ['libprotobuf_hdrs', 'libprotobuf_lite_hdrs', 'libprotoc_hdrs']
src_path = 'src/google/protobuf'
file_lists = 'src/file_lists.cmake'
prefix = '${protobuf_SOURCE_DIR}/src/google/protobuf/'

def extract_set_content(set_name, file_path, transform_func: None):
    lines_in_set = []
    in_set = False

    with open(file_path, 'r') as file:
        for line in file:
            if line.strip().startswith(f'set({set_name}'):
                in_set = True
            elif in_set & line.strip().startswith(')'):
                in_set = False
                break
            elif in_set:
                if transform_func is not None:
                    line = transform_func(line)
                lines_in_set.append(line.strip())

    return lines_in_set

def path_transform(line):
    line = line.strip()
    if line.startswith(prefix):
        return line[len(prefix):]
    return line

def create_include_symlinks(source_dir, include_dir, files_list_start_line, files_list_end_line):
    print("TODO:")

if not os.path.exists(src_path):
    print("source does not exist")
    exit(1)

for file_set_name in file_set_names:
    inc_path = os.path.join(os.path.join(src_path, "include"), os.path.join(file_set_name, "google/protobuf"))
    if not os.path.exists(inc_path):
        print(f"destination does not exist at: '{os.getcwd()}'")
        os.makedirs(inc_path)

    input_files = extract_set_content(file_set_name, file_lists, path_transform)

    if len(input_files) == 0:
        print(f"no input files found for file set '{file_set_name}'")
        exit(0)

    for file in enumerate(input_files):
        file_path = file[1]

        #append file path to both source and dest path
        source_file = os.path.join(src_path, file[1])
        if not os.path.exists(source_file):
            print(f"source file not found: '{source_file}'")
            exit(1)

        dest_file = os.path.join(inc_path, file[1])
        dest_dir = os.path.dirname(dest_file)

        if not os.path.exists(dest_dir):
            print(f"creating dir: '{dest_dir}'")
            os.makedirs(dest_dir)

        symlink_path = os.path.relpath(source_file, dest_dir)
        try:
            os.symlink(symlink_path, dest_file)
        except OSError as error:
            print(f"failed to create symlink for {file}: {error}")
