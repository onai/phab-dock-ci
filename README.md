# Phab-dock-CI
A CI workflow for arcanist and testing of Docker images.

# Table Of Contents
1. [Background](#background)
2. [Workflow](#workflow)
3. [How To Run](#how-to-run)


# Background
This project provides scripts that enable one to leverage Buildbot CI (Continuous Integration) with Phabricator’s Harbormaster. Any code review in Phabricator triggers a `change_hook` request in buildbot and it runs the `docker build` and `docker run` command in the buildbot instance. Build results will be sent to Phabricator using the scripts in this repository. This way, utility docker images can be tested in an automated fashion as part of a development workflow.

# Workflow
Here are the steps in the workflow:

1. Programmer submits code for review by committing changes and running an “arc diff” (Differential)
2. Code review triggers Herald rules which triggers a Harbormaster build plan
3. Harbormaster build plan makes HTTP requests to remote builders and can wait for status report from the builders. Status will be reported back to Herald.
4. If a repository has a staging area, Differential (code review) will create a new tag for the review and that tag will be pushed to the staging repository.
5. A push to the staging repository triggers the `change_hook`.
6. Buildbot's change_hook will use the tag to checkout and build the repository.
7. Build report is sent to Harbormaster and then to Herald.
8. Finally, the build status will be visible in the Differential review page.


# How To Run
1. Setup Buildbot with http://docs.buildbot.net/current/tutorial/tour.html
2. Install Docker in the buildbot instance: https://docs.docker.com/engine/install/
3. Setup Phabricator with https://secure.phabricator.com/book/phabricator/article/installation_guide/
4. Create a Harbormaster build plan with https://secure.phabricator.com/book/phabricator/article/harbormaster/
5. In the build instructions, make a HTTP POST request to your buildbot instance
`http://<your_buildbot_url>/change_hook?project=<your_project_name>&repository=${repository.staging.uri}&revision=${buildable.diff}&PHID=${target.phid}&author=s&comments=''"`
6. Create a Herald rule for repository actions such as push, code review, etc. with https://secure.phabricator.com/book/phabricator/article/herald/
7. Place the shell scripts in this repository in the desired place in the buildbot instance
8. Modify `master.py` in Buildbot instance to add required build steps http://docs.buildbot.net/latest/manual/configuration/buildsteps.html
9. Call `fetchRevision.sh` to fetch the right review tag.
10. Call `docker build` and `docker run` commands to build the image and run the container.
11. Call the `hbSendSuccess.sh` or `hbSendFailure.sh` scripts if the build passes or fails in `master.py`.
12. If build is successful, you can also have a build step to push to your docker registry.



