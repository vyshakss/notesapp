
current_file="/mnt/163A2B503A2B2C65/notepadapp/test1.txt"
mkdir -p "$(dirname "$current_file")"
while true; do
#to create file if its not there
if [  -f "$current_file" ]; then
load_arg="--filename=$current_file"
else
load_arg=""
fi
content=$(zenity --text-info --editable $load_arg --title="$current_file" --ok-label="Save" --cancel-label="Discard" --extra-button="Open" --extra-button="New file" --width=600 --height=600 --font="Monospace 12")
exit_code=$?
if [ "$content" = "New file" ]; then
new_path=$(zenity --file-selection --save \
                   --title="Create New Note" \
                   --filename="/mnt/163A2B503A2B2C65/notepadapp/Untitled.txt")
if [ -n "$new_path" ]; then
current_file="$new_path"
fi
continue
elif [ "$content" = "Open" ]; then
new_selection=$(zenity --file-selection --filename="/mnt/163A2B503A2B2C65/notepadapp/")
if [ -n "$new_selection" ]; then
current_file="$new_selection"
fi
continue
elif [ $exit_code -eq 0 ]; then
timestamp=$(date "+%Y=%m-%d %H:%M:%S") 
lines=$(wc -l < "$current_file")
words=$(wc -w < "$current_file")
echo -e "$content\n\n[Saved: $timestamp]\n[linecount=$lines]\n [words=$words]" > "$current_file"
zenity --notification --text="Saved"
else
break
fi
done
