# Git and Basics Tutorial

## Git Basics

### Install Git

1. **Check if Git is Installed:** Open a terminal (Command Prompt or PowerShell in Windows, Terminal in macOS or Linux) and type:
   ```bash
   git --version
   ```
   If Git is installed, this command will return the version number. If not, proceed to step 2.

2. **Download and Install Git:** Go to [git-scm.com](https://git-scm.com/) and download the version appropriate for your operating system. Follow the installation instructions.

### Initialize a New Git Repository

1. **Create a New Folder:** Create a folder where you want your new Git repository to be.
   
2. **Initialize the Repository:**
   Open a terminal, navigate to your newly created folder, and type:
   ```bash
   git init
   ```

### Make Your First Commit

1. **Create a File:** In the repository folder, create a new text file and add some content to it.

2. **Add the File to Staging:** In the terminal, add the file to the staging area with:
   ```bash
   git add <filename>
   ```

3. **Commit the File:** Commit the staged file to your repository:
   ```bash
   git commit -m "Initial commit"
   ```

### Create and Switch Branches

1. **Create a 'Student' Branch:** Create a new branch named after your last name and first initial or callsign:
   ```bash
   git branch <branch-name>
   ```

2. **Switch to the New Branch:** Switch to your newly created branch with:
   ```bash
   git checkout <branch-name>
   ```

### Add a README.md

1. **Create README.md:** In the repository, create a `README.md` file and add initial content.

2. **Commit the New File:** Add and commit the `README.md` to your branch:
   ```bash
   git add README.md
   git commit -m "Add README.md"
   ```

### Observe Branch Changes

1. **Switch to 'main' Branch:** Switch back to the 'main' branch and note that `README.md` is not there.
   
2. **Switch Back to 'Student' Branch:** Switch back to your 'student' branch to see `README.md` again.

### Modify, Reset, and Merge

1. **Modify README.md:** Add more text to your `README.md`, commit the changes.

2. **Delete README.md:** Delete the `README.md` file (simulate an accident).

3. **Reset the Branch:** Reset your branch to the last commit to restore `README.md`:
   ```bash
   git reset --hard HEAD
   ```

4. **Pull Changes from 'Main':** Ensure you have the latest changes from 'main':
   ```bash
   git pull origin main
   ```

5. **Merge 'Main' with 'Student':** Merge the 'main' branch into your 'student' branch to integrate any changes:
   ```bash
   git merge main
   ```

