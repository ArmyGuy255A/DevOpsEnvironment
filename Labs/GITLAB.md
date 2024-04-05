# GitLab Basics Tutorial

## GitLab Basics

### Setting Up a GitLab Repository

1. **Login to GitLab:** Visit [https://x.x.x.x:8443](https://x.x.x.x:8443) and login or create an account.

2. **Create a New Git Repository:** Follow the GitLab instructions to create a new repository. Make sure it's empty.

3. **Connect Your Local Repository:** Point your local repository to the GitLab remote:
   ```bash
   git remote add origin <repository-URL>
   ```

4. **Push to GitLab:** Push your branches to GitLab:
   ```bash
   git push -u origin --all
   ```

5. **Verify on GitLab:** Login to GitLab to see your pushed `README.md`.

### Cloning with HTTPS and SSH

1. **Clone Using HTTPS:** Delete your local repository folder, then clone using HTTPS:
   ```bash
   git clone <https-repository-URL>
   ```

2. **Set Up SSH (if needed):** If you don't have an SSH key, generate one:
   ```bash
   ssh-keygen
   ```
   Follow the prompts, then add your SSH key to GitLab under user settings.

3. **Clone Using SSH:** Delete the HTTPS cloned folder, then clone using SSH:
   ```bash
   git clone <ssh-repository-URL>
   ```

### Create a Pull Request

#### Understanding Pull Requests

Pull Requests (PRs) are fundamental to the collaborative development process and a cornerstone of good Git practice. PRs provide a structured way for developers to propose changes, allow for those changes to be reviewed by team members, and incorporate a level of quality control through automated Continuous Integration (CI) checks. This process ensures that:

- **Code Quality is Maintained:** PRs enable peer review of the code, fostering better code quality and shared code ownership.
- **Features are Isolated:** Working in branches and using PRs helps in isolating features or bug fixes, making it easier to manage and integrate changes.
- **Builds are Automated:** With CI/CD pipelines, you can automatically run tests and checks against the proposed changes, ensuring that new code does not break existing functionality.

In production environments, it is crucial to maintain the integrity and stability of the 'main' branch. Direct commits to 'main' can bypass the necessary checks and reviews, potentially introducing errors or unstable features into the production environment. By utilizing PRs, teams can ensure that changes are thoroughly vetted before they are merged.

#### Creating a PR on GitLab

To create a Pull Request, which is known as a Merge Request (MR) in GitLab, follow these steps:

1. **Push Your Branch:** Make sure your 'student' branch is pushed to GitLab. If not, use:
   ```bash
   git push -u origin <branch-name>
   ```
2. **Navigate to Your Repository on GitLab:** Log in to your GitLab account and go to your project's repository.
3. **Create New Merge Request:** Click on the 'Merge Requests' tab in the left panel, then click on the green 'New merge request' button.
4. **Select Source and Target Branch:** Choose your 'student' branch as the source and 'main' as the target branch for the merge request.
5. **Fill Out the Merge Request Form:** Enter a title and description for your MR. This information helps reviewers understand the purpose of your changes.
6. **Submit the Merge Request:** Click on the "Submit merge request" button to create the MR.

After submitting, your team members or classmates can review the changes, leave comments, and suggest improvements.

### Completing a Pull Request

#### Squash and Merge

Squashing commits during a merge is a way to streamline your project’s history by combining multiple commit entries into a single comprehensive commit. This is particularly useful for cleaning up the commit history before integrating a feature branch into 'main'.

To complete a Pull Request with squash and merge on GitLab:

1. **Review the Merge Request:** Ensure the MR is approved by your team members or instructors and that all CI checks have passed.
2. **Squash Commits:** In the Merge Request view, look for the "Squash commits" option. GitLab may automatically suggest this option if there are multiple commits. Check the box to enable it.
3. **Merge the Request:** Click on the "Merge" button. GitLab will combine all the commits from your 'student' branch into a single commit and merge it into the 'main' branch.
4. **Confirm Merge:** You may be asked to confirm the action and finalize any merge commit messages.
5. **Delete the Branch:** After merging, you can delete the 'student' branch if it's no longer needed.

This action not only keeps the project history cleaner but also ensures that each feature or bug fix is represented by a single commit, making it easier to track changes and revert them if necessary.

### Next Lesson
Proceed to [Lab 3 - GitLab CI/CD Basics](GITLAB-CICD.md) to learn about CI/CD Pipelines within GitLab.