#!/usr/bin/env python3
""" Create or Update Pull Request """
from github import Github, GithubException
import os


def cs_string_to_list(str):
    # Split the comma separated string into a list
    l = [i.strip() for i in str.split(",")]
    # Remove empty strings
    return list(filter(None, l))


def create_project_card(github_repo, project_name, project_column_name, pull_request):
    # Locate the project by name
    project = None
    for project_item in github_repo.get_projects("all"):
        if project_item.name == project_name:
            project = project_item
            break

    if not project:
        print("::error::Project not found. Unable to create project card.")
        return

    # Locate the column by name
    column = None
    for column_item in project.get_columns():
        if column_item.name == project_column_name:
            column = column_item
            break

    if not column:
        print("::error::Project column not found. Unable to create project card.")
        return

    # Create a project card for the pull request
    column.create_card(content_id=pull_request.id, content_type="PullRequest")
    print(
        "Added pull request #%d to project '%s' under column '%s'"
        % (pull_request.number, project.name, column.name)
    )


def create_or_update_pull_request(
    github_token,
    github_repository,
    branch,
    base,
    title,
    body,
    labels,
    assignees,
    milestone,
    reviewers,
    team_reviewers,
    project_name,
    project_column_name,
):
    # Create the pull request
    github_repo = Github(github_token).get_repo(github_repository)
    try:
        pull_request = github_repo.create_pull(
            title=title, body=body, base=base, head=branch
        )
        print(f"Created pull request #{pull_request.number} ({branch} => {base})")
    except GithubException as e:
        if e.status == 422:
            # A pull request exists for this branch and base
            head_branch = "{}:{}".format(github_repository.split("/")[0], branch)
            # Get the pull request
            pull_request = github_repo.get_pulls(
                state="open", base=base, head=head_branch
            )[0]
            print(f"Updated pull request #{pull_request.number} ({branch} => {base})")
        else:
            print(str(e))
            raise

    # Set the output variables
    os.system(f"echo ::set-env name=PULL_REQUEST_NUMBER::{pull_request.number}")
    os.system(f"echo ::set-output name=pr_number::{pull_request.number}")

    # Set labels, assignees and milestone
    if labels is not None:
        print(f"Applying labels '{labels}'")
        pull_request.as_issue().edit(labels=cs_string_to_list(labels))
    if assignees is not None:
        print(f"Applying assignees '{assignees}'")
        pull_request.as_issue().edit(assignees=cs_string_to_list(assignees))
    if milestone is not None:
        print(f"Applying milestone '{milestone}'")
        milestone = github_repo.get_milestone(int(milestone))
        pull_request.as_issue().edit(milestone=milestone)

    # Set pull request reviewers
    if reviewers is not None:
        print(f"Requesting reviewers '{reviewers}'")
        try:
            pull_request.create_review_request(reviewers=cs_string_to_list(reviewers))
        except GithubException as e:
            # Likely caused by "Review cannot be requested from pull request author."
            if e.status == 422:
                print("Request reviewers failed - {}".format(e.data["message"]))

    # Set pull request team reviewers
    if team_reviewers is not None:
        print(f"Requesting team reviewers '{team_reviewers}'")
        pull_request.create_review_request(
            team_reviewers=cs_string_to_list(team_reviewers)
        )

    # Create a project card for the pull request
    if project_name is not None and project_column_name is not None:
        try:
            create_project_card(
                github_repo, project_name, project_column_name, pull_request
            )
        except GithubException as e:
            # Likely caused by "Project already has the associated issue."
            if e.status == 422:
                print(
                    "Create project card failed - {}".format(
                        e.data["errors"][0]["message"]
                    )
                )
