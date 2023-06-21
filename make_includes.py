#!/usr/local/bin/python3

import os

src_path = 'src/google/protobuf'
inc_path = 'include/google/protobuf'
file_lists = 'src/file_lists.cmake'

def read_files(start_line, end_line, transform_func: None):
    try:
        with open(file_lists, 'r') as file:
            current = 1
            lines = []
            while current < start_line:
                file.readline()
                current += 1
            while current <= end_line:
                line = file.readline()
                if transform_func is not None:
                    line = transform_func(line)
                lines.append(line)
                current += 1
            
            return lines
    except FileNotFoundError:
        print(f"File not found: {file_path}")
        return None
    except Exception as e:
        print(f"Error: {e}")
        return None
        
if not os.path.exists(src_path):
    print("source does not exist")
    exit(1)

if not os.path.exists(inc_path):
    print(f"destination does not exist at: '{os.getcwd()}'")
    os.makedirs(inc_path)

prefix = '${protobuf_SOURCE_DIR}/src/google/protobuf/'
def path_transform(line):
    line = line.strip()
    if line.startswith(prefix):
        return line[len(prefix):]
    return line

def create_include_symlinks(source_dir, include_dir, files_list_start_line, files_list_end_line):
    print("TODO:")
    
input_files = read_files(92, 196, path_transform)
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
