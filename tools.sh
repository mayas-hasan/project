#Function to mark a study day as completed and calculate progress
mark_lesson_complete() {
echo " Mark Lesson as Completed"

#List all available plan files or exit if none found
ls plans/*.txt 2>/dev/null || { echo "No plans found."; return; }

#Ask user to enter the subject name
read -p "Enter the subject name: " subject
file="plans/${subject}_plan.txt"

#check if the specified plan exists
if [ ! -f "$file" ]; then
echo "Plan not found."
return
fi

#Display all remaining days in the plan
grep "^Day" "$file"
echo

#Ask user to choose a day number to mark as completed
read -p "Enter the day number to mark as completed (e.g., 1): " day

#Check if the entered day exists in the plan
if grep -q "^Day $day " "$file"; then
#Count the inintian numbers of the study days
initial_days=$(grep "^Day" "$file" | wc -l)

#Remove the selected day from the plan file
sed -i "/^Day $day /d" "$file"

log_action "Marked Day $day as completed in $subject"
echo "Day $day removed from the plan."

# Calculate progress
remaining=$(grep "^Day" "$file" | wc -l)
completed=$((initial_days - remaining + 1))
progress=$(awk "BEGIN {printf \"%.2f\", (completed / (initial_days + 1)) * 100}")
echo "Progress: $progress% completed"
else
echo "Day not found."
fi
}
