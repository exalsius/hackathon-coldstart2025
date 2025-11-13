#!/bin/bash
#
# Submit SLURM evaluation jobs for teams
#
# Usage: ./evaluate_teams.sh team01 team02 ...
#

set -e

# Require team names as arguments
if [ $# -eq 0 ]; then
    echo "Usage: $0 team01 team02 ..."
    exit 1
fi

TEAMS=("$@")

echo "========================================"
echo "BATCH TEAM EVALUATION"
echo "========================================"
echo "Teams: ${#TEAMS[@]}"
echo ""

SUBMITTED_JOBS=()
LOG_FILES=()

for team in "${TEAMS[@]}"; do
    team_home="/home/${team}"

    echo "Submitting: ${team}"

    if [ ! -d "$team_home/coldstart" ]; then
        echo "  ✗ Repository not found at $team_home/coldstart"
        continue
    fi

    # Submit job with HOME and USER override
    cd "$team_home/coldstart"
    JOB_OUTPUT=$(USER="$team" HOME="$team_home" /scratch/submit-job.sh "DATASET_DIR=/home/datasets/cold-start-hackathon/ python evaluate.py" --gpu --name "eval_${team}")
    JOB_ID=$(echo "$JOB_OUTPUT" | grep -oP 'job \K[0-9]+')
    LOG_FILE=$(echo "$JOB_OUTPUT" | grep -oP 'Logs: \K.*')

    SUBMITTED_JOBS+=("${team}:${JOB_ID}")
    LOG_FILES+=("$LOG_FILE")
    echo "  ✓ Job ${JOB_ID} (eval_${team}) submitted"
done

echo ""
echo "========================================"
echo "SUBMITTED ${#SUBMITTED_JOBS[@]} JOBS"
echo "========================================"
for job in "${SUBMITTED_JOBS[@]}"; do
    echo "  ${job}"
done
echo ""
echo "Log files:"
for log in "${LOG_FILES[@]}"; do
    echo "  ${log}"
done
echo ""
echo "Monitor: squeue -u root"
echo "========================================"
