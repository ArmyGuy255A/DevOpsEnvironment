# GitLab CI/CD Pipelines Tutorial

This tutorial guides you through setting up a basic Continuous Integration/Continuous Deployment (CI/CD) pipeline in GitLab using `.gitlab-ci.yml`, demonstrating the functionality with both Shell and Docker-in-Docker runners.

## Understanding `.gitlab-ci.yml`

The `.gitlab-ci.yml` file is the heart of the CI/CD process in GitLab. It specifies how GitLab Runner should execute the CI/CD tasks. You can define various stages such as build, test, and deploy, and within these stages, you can define jobs that run scripts.

For comprehensive details on the syntax and capabilities of `.gitlab-ci.yml`, visit the official GitLab documentation: [GitLab CI/CD YAML Reference](https://docs.gitlab.com/ee/ci/yaml/).

## GitLab Runners

Runners are servers that process your CI/CD jobs. Your lab has two types of runners configured:

- **Shell Runner:** Executes jobs directly on the machine where it's installed, using the shell of the operating system.
- **Docker-in-Docker Runner:** Allows jobs to run inside Docker containers, which can be especially useful for building and testing in isolated environments.

The choice between Shell and Docker-in-Docker runners depends on your project's needs. Docker-in-Docker is great for consistency across environments and isolating dependencies, while Shell runners might be faster for simple tasks that don't require Docker.

## Setting Up Your First Pipeline

1. **Navigate to Your Repository in GitLab:** Go to the Build -> Jobs area.

2. **Create CI/CD Configuration File:** Click on "Configure Pipeline." You'll be presented with a default `.gitlab-ci.yml` template that outlines a basic pipeline with build, test, and deploy stages. This template uses `echo` commands to simulate actual work for demonstration purposes.

Here's a sample `.gitlab-ci.yml` file:

```yaml
# This file is a template, and might need editing before it works on your project.
# This is a sample GitLab CI/CD configuration file that should run without any modifications.
# It demonstrates a basic 3 stage CI/CD pipeline. Instead of real tests or scripts,
# it uses echo commands to simulate the pipeline execution.
#
# A pipeline is composed of independent jobs that run scripts, grouped into stages.
# Stages run in sequential order, but jobs within stages run in parallel.
#
# For more information, see: https://docs.gitlab.com/ee/ci/yaml/index.html#stages
#
# You can copy and paste this template into a new `.gitlab-ci.yml` file.
# You should not add this template to an existing `.gitlab-ci.yml` file by using the `include:` keyword.
#
# To contribute improvements to CI/CD templates, please follow the Development guide at:
# https://docs.gitlab.com/ee/development/cicd/templates.html
# This specific template is located at:
# https://gitlab.com/gitlab-org/gitlab/-/blob/master/lib/gitlab/ci/templates/Getting-Started.gitlab-ci.yml

stages:          # List of stages for jobs, and their order of execution
  - build
  - test
  - deploy

build-job:       # This job runs in the build stage, which runs first.
  stage: build
  script:
    - echo "Compiling the code..."
    - echo "Compile complete."

unit-test-job:   # This job runs in the test stage.
  stage: test    # It only starts when the job in the build stage completes successfully.
  script:
    - echo "Running unit tests... This will take about 60 seconds."
    - sleep 60
    - echo "Code coverage is 90%"

lint-test-job:   # This job also runs in the test stage.
  stage: test    # It can run at the same time as unit-test-job (in parallel).
  script:
    - echo "Linting code... This will take about 10 seconds."
    - sleep 10
    - echo "No lint issues found."

deploy-job:      # This job runs in the deploy stage.
  stage: deploy  # It only runs when *both* jobs in the test stage complete successfully.
  environment: production
  script:
    - echo "Deploying application..."
    - echo "Application successfully deployed."

```

### Understanding the Default Pipeline

The default pipeline template includes:

- Three stages: `build`, `test`, and `deploy`.
- Jobs that echo messages and simulate execution time with `sleep`.

This setup helps understand how jobs progress through stages and how multiple jobs can run in parallel within the same stage.

### Commit the Default Pipeline

1. **Commit the Changes:** Save the `.gitlab-ci.yml` to your repository and commit the changes.

2. **View the Pipeline:** Click on "View Pipeline" to see your newly created pipeline in action. The Shell runner will execute the defined jobs, showing the basic functionality of a GitLab CI/CD pipeline.

## Modifying the Pipeline for Branch-Specific Deployment

### Restricting Deployment to the 'Main' Branch

To ensure that the `deploy` job runs only on the 'main' branch:

1. **Edit the `.gitlab-ci.yml` File:** Use the web editor to modify the `deploy-job` definition by adding an `only` clause:
   ```yaml
   deploy-job:
     stage: deploy
     script:
       - echo "Deploying application..."
       - echo "Application successfully deployed."
     only:
       - main
   ```
2. **Commit Your Changes:** Save and commit the modified `.gitlab-ci.yml` directly to the 'main' branch.

### Testing the Branch-Specific Deployment

1. **Pull the Latest Changes:** Ensure your local git directory is up to date with the latest changes from GitLab.
```bash
git pull origin main
```
   
2. **Create a New Branch:** Create a new branch from 'main' named `/dev/student`.
```bash
git checkout -b dev/student
```

3. **Add a Test File:** Create a file named `DEV-STUDENT.md`, add some text, and commit the changes.
```bash
echo "This is a test file for the student branch." > DEV-STUDENT.md
git add DEV-STUDENT.md
git commit -m "Add DEV-STUDENT.md"
```

4. **Push the New Branch:** Push your `/dev/student` branch to the GitLab repository.
```bash
git push -u origin dev/student
```

5. **Observe the Pipeline:** Navigate back to the Jobs section in GitLab. You should see that the pipeline runs, but the `deploy` job does not execute since the changes are not in the 'main' branch.

### Completing a Merge Request

1. **Create a Merge Request:** From your `/dev/student` branch to 'main'. This demonstrates how to use GitLab for code reviews and merging.

2. **Complete the Merge Request:** After reviewing, complete the merge request. This will trigger the pipeline again on the 'main' branch.

3. **Observe Final Pipeline Execution:** Notice how this time, all stages including the `deploy` job are executed, demonstrating branch-specific actions in your CI/CD pipeline.

This tutorial covers the basics of setting up a CI/CD pipeline in GitLab, focusing on practical demonstrations with both Shell and Docker-in-Docker runners, and showcasing branch-specific deployment strategies.