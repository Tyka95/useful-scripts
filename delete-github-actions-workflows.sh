# Requires GitHub CLI installed and authenticated.
# Executed in bash
# Can be execute it multiple times
gh api repos/USER_NAME/REPO_NAME/actions/runs | jq -r '.workflow_runs[].id' | while read -r value; do
    value=$(echo "$value" | tr -d '\r')
    echo "Deleting $value"
    gh api -X DELETE "repos/USER_NAME/REPO_NAME/actions/runs/$value"
done


# specify branch
branch="main"

gh api repos/USER_NAME/REPO_NAME/actions/runs?branch=$branch | jq -r '.workflow_runs[].id' | while read -r value; do
    value=$(echo "$value" | tr -d '\r')
    echo "Deleting workflow run with ID: $value"
    gh api -X DELETE "repos/USER_NAME/REPO_NAME/actions/runs/$value"
done

# specify branch and status
# statuses: queued, in_progress, or completed
branch="main"
status="completed"
gh api repos/USER_NAME/REPO_NAME/actions/runs?branch=$branch&status=$status | jq -r --arg status "$status" '.workflow_runs[] | select(.status == $status).id' | while read -r value; do
    value=$(echo "$value" | tr -d '\r')
    echo "Deleting workflow run with ID $value"
    gh api -X DELETE "repos/USER_NAME/REPO_NAME/actions/runs/$value"
done
