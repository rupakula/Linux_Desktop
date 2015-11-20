gcc -w  -o output filr_main.c -D_FILE_OFFSET_BITS=64 `pkg-config fuse --cflags --libs` 
rm /tmp/ids.csv

