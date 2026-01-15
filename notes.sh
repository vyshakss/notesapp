notes_file="/mnt/163A2B503A2B2C65/notepadapp/test1.txt"
mkdir -p "$(dirname "$notes_file")"
#to create file if its not there
if [ ! -f "$notes_file" ]; then
touch "$notes_file"
fi
content=$(zenity --text-info --editable --filename="$notes_file" --title="Notes" --ok-label="Save" --cancel-label="Discard" --width=600 --height=600 --font="Monospace 12")
if [ $? -eq 0 ]; then 
echo "$content" > "$notes_file"
zenity --notification --text="Saved"
fi
