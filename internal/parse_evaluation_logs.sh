#!/bin/bash
# parse_evaluation_logs.sh - Extract team names and Test Avg AUROC from evaluation logs
# Usage: ./parse_evaluation_logs.sh [log_directory]

LOG_DIR="${1:-.}"

echo "Team Name,Test Avg AUROC"
echo "========================"

# Collect results in a temporary array
results=()

for logfile in "$LOG_DIR"/*.out; do
  [ -f "$logfile" ] || continue

  # Extract team name from filename (e.g., job328_eval_team00.out -> team00)
  filename=$(basename "$logfile")
  team_name=$(echo "$filename" | grep -oE 'team[0-9]+')

  # Skip if no team name found in filename
  [ -z "$team_name" ] && continue

  # Extract Test Avg AUROC value
  test_avg=$(grep "Test Avg" "$logfile" | awk '{print $NF}')

  # Store result (use 0.0000 for N/A to sort them last)
  if [ -z "$test_avg" ]; then
    results+=("0.0000 $team_name N/A")
  else
    results+=("$test_avg $team_name $test_avg")
  fi
done

# Sort by AUROC (descending) and print
printf '%s\n' "${results[@]}" | sort -rn | while read auroc team_name display_auroc; do
  printf "%-10s %s\n" "$team_name" "$display_auroc"
done
