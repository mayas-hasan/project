generate_plan() {
  echo "==== Create New Study Plan ===="
  read -p "Enter subject name: " subject
  read -p "Enter total number of lessons: " total_lessons
  read -p "Enter number of remaining days: " remaining_days

  if ! [[ "$total_lessons" =~ ^[0-9]+$ && "$remaining_days" =~ ^[0-9]+$ && "$remaining_days" -gt 0 ]]; then
    echo "Invalid input. Please enter valid numbers."
    return
  fi

  lessons_per_day=$((total_lessons / remaining_days))
  extra_lessons=$((total_lessons % remaining_days))
  plan_file="plans/${subject}_plan.txt"

  {
    echo "Study Plan for $subject"
    echo "Total lessons: $total_lessons"
    echo "Days: $remaining_days"
    echo "------------------------------------"
    for (( day=1; day<=remaining_days; day++ )); do
      if [ $day -le $extra_lessons ]; then
        lessons=$((lessons_per_day + 1))
      else
        lessons=$lessons_per_day
      fi
      echo "Day $day - Study $lessons lesson(s)"
    done
  } > "$plan_file"

  log_action "Study plan created: $plan_file"
  echo "Plan created and saved as: $plan_file"
}
