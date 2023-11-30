#!/bin/bash

# Check if a project name and language(s) are provided
if [ -z "$1" ]; then
	echo "Usage: $0 <project_name> [<language1> <language2> ...]"
	exit 1
fi

project_name=$1
languages=("${@:2}")

echo "Creating project directories..."
mkdir -p $project_name
cd $project_name

# Function to create project structure for a specific language
create_project() {
	language=$1
	echo "Creating $language project..."

	case $language in
	typescript_bun)
		mkdir -p typescript_bun
		cd typescript_bun
		bun init -y >/dev/null
		cd ..
		;;
	python)
		mkdir -p python
		touch python/main.py
		;;
	c)
		mkdir -p c
		touch c/main.c
		;;
	cpp)
		mkdir -p cpp
		touch cpp/main.cpp
		;;
	rust)
		cargo new rust 2>/dev/null
		;;
	golang)
		mkdir -p golang
		cd golang
		go mod init ratnadeep007/aoc_$project_name 2>/dev/null
		touch main.go
		cd ..
		;;
	zig)
		mkdir -p zig
		cd zig
		zig init-exe 2>/dev/null
		cd ..
		;;
	elixir)
		mix new elixir_$project_name >/dev/null
		;;
	ocaml)
		eval $(opam env) 2>/dev/null
		dune init proj ocaml 2>/dev/null
		;;
	*)
		echo "Unsupported language: $language"
		;;
	esac
}

# If no languages provided, create projects for all languages
if [ ${#languages[@]} -eq 0 ]; then
	languages=("typescript_bun" "python" "c" "cpp" "rust" "golang" "zig" "elixir" "ocaml")
fi

# Create projects for specified languages
for lang in "${languages[@]}"; do
	create_project $lang
done

echo "Project structure created successfully!"
