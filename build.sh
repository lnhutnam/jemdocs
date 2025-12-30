#!/bin/bash
# Build script for jemdoc website

set -e

CONFIG="mysite.conf"
PYTHON="python3"

# Color output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to build a single file
build_file() {
    local source=$1
    local target="${source%.jemdoc}.html"
    echo -e "${BLUE}Building${NC} $target ${BLUE}from${NC} $source"
    $PYTHON jemdoc.py -c $CONFIG -o $target $source
}

# Function to build all files
build_all() {
    echo -e "${GREEN}Building all pages...${NC}"
    build_file "index.jemdoc"
    build_file "education.jemdoc"
    build_file "publications.jemdoc"
    build_file "teaching.jemdoc"
    build_file "services.jemdoc"
    build_file "students.jemdoc"
    build_file "awards.jemdoc"
    echo -e "${GREEN}Build complete!${NC}"
}

# Function to clean generated files
clean() {
    echo -e "${BLUE}Cleaning generated HTML files...${NC}"
    rm -f index.html education.html publications.html teaching.html \
          services.html students.html awards.html
    echo -e "${GREEN}Clean complete!${NC}"
}

# Function to show help
show_help() {
    echo "jemdoc Website Build Script"
    echo ""
    echo "Usage: ./build.sh [command]"
    echo ""
    echo "Commands:"
    echo "  all       - Build all HTML files from .jemdoc sources (default)"
    echo "  clean     - Remove all generated HTML files"
    echo "  rebuild   - Clean and rebuild all files"
    echo "  help      - Show this help message"
    echo ""
    echo "Examples:"
    echo "  ./build.sh           - Build all pages"
    echo "  ./build.sh clean     - Remove generated files"
    echo "  ./build.sh rebuild   - Clean and rebuild everything"
}

# Main script logic
case "${1:-all}" in
    all)
        build_all
        ;;
    clean)
        clean
        ;;
    rebuild)
        clean
        build_all
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        echo "Error: Unknown command '$1'"
        echo ""
        show_help
        exit 1
        ;;
esac
