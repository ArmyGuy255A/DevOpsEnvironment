# GitLab Basics Tutorial

## GitLab Basics

### Setting Up a GitLab Repository

1. **Login to GitLab:** Visit [gitlab.com](https://gitlab.com/) and login or create an account.

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

1. **Understanding Pull Requests:** Explain the importance of never committing directly to 'main' in production environments. Pull Requests (PRs) allow for code review and CI checks.

2. **Creating a PR on GitLab:** Show students how to create a PR from their 'student' branch to 'main' on GitLab.

### Completing a Pull Request

1. **Squash and Merge:** Walk students through squashing

 their commits and merging their PR into 'main' on GitLab, explaining the process and purpose.

This guide covers the essentials of using Git and GitLab, designed to help students understand version control basics and collaborative development practices.