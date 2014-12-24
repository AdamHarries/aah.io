---
title: Git small team workflow tutorial
---

This is a simple (and hopefully short) guide to using git, with a single repository, to facilitate collaborative a project within a small team.

# How to use git:

##Step zero: set up git

This tutorial isn't really going to go into this, but it is going to assumme that you've set up everything needed to use Git from the command line. It also assummes that you're set up with Github, and if the repository that you're going to be working with is private, then you're listed as a collaborator.

##Step one: get the code.

The first step is to get the code that you're going to be working on. We're going to do this by setting up a local repository and cloning the remote repository (the one on Github, or wherever) into it.

To begin, fire up a terminal, and navigate to the folder *above* where you're going to store the code. This means that if you want it to be stored in `/Simple/Path/To/Project/` then we want to be in `/Simple/Path/To/`

We're then going to clone it. To do this, run the command:

```bash
git clone git@github.com:<USERNAME>\<PROJECT_NAME>.git
```

Where `<USERNAME>` is the github username of the listed owner of the repository `<PROJECT_NAME>`

This will create a folder named `<PROJECT_NAME>` in the folder you're in, and pull all the content from the remote repository into it. Change directory into it, `cd` on most operating systems, and verify that the code is there. We'll be working from this folder from now on.

##Step two: getting changes from the remote.

Sooner or later we're going to want to get the code that other people have written onto our machine. To do this, we're going to use the `pull` command. I'm purposefully explaining this command first, as it's required if there are problems committing (sending your own code to the repository), which will be handled later.

The syntax of the command is rather simple:

```bash
git pull
```

This should pull all changes from the remote repository into your own local repo, allowing you to build on others work, or try out their features.

##Step three: sending your changes to the server

As mentioned, git treats remote and local repositories as seperate, meaning that it requires 2-3 commands to send local changes to code up to the server.

Our three commands are as follows:

```bash
git add *
git commit -a -m "<COMMIT_MESSAGE>"
git push
```

The commands are fairly obvious. `git add *` is optional; it tells git to start tracking all the files in a repository. This only needs to be run once (at the start), and every time you add a new file that you want to push up to the repo. To selectively add files, simply use `git add <filename>`, or for a file type `git add *.<fietype>`.

The second command stages a commit in the local repository. The `-a` argument tells it to add all changes to the commit, and the `-m <COMMIT_MESSAGE>` allows you to add a short message describing your changes (this is obligatory).

The final command pushes your local commit (and all changes) up to the remote repository. At the command the entire process can fail, for example if the repositorys are out of sync. 

###When pushing your code up goes wrong

One of the most important concepts in git is *commits*. These represent declarations of changes to the repository which git uses to track differences between two repos. When you're finished editing code, you can *commit* it, and then send it up to the remote repository (the fine details of this will be covered later). 

Git push goes wrong when the commits between your local repo and the remote repo get out of sync. Consider the following series of events:

1. Developers A and B both get the most recent set of code from the remote repository using `git pull`
2. Developer A makes a bunch of changes, commits them to his local repo, and sends the commit (with the changes) up to the remote repository.
3. Developer B also makes some changes, and trys to commit them to his local repo, and send them up to the remote.

At this point, developer B's push to the server fails, as her local repo's previous commit is different to the commit that's currently on the server. Because of this, git has no idea how to merge the two code bases together, which causes it to fail.

####So how do I solve it?

To solve this, we're going to have to merge the commits manually, and then push the result up to the server.

To begin with, we're going to call the `git pull` command again. This should open up an editor and allow us to enter a message describing why we need to merge the commits together. Add a couple of lines describing the reason, and save and close from the editor.

In some cases at this point git will simply automatically merge the non-matching files together (which is great), allowing us to simply recommit and push our changes to the server, and carry on with our lives.

If git doesn't (for example if both developers edited the same line in the same file to say different things), we're going to need to call another command before `git push`. The command we need is `git mergetool -y`. This allows us to interactively manually manage merging individual files. To merge two files (using the merge tool) is beyond the scope of this tutorial, as there are lots of different merge tools out there, each with their own quirks. Once the merge is over, recommit and push to the server.

##Final thoughts

I hope this guide has been helpful. For any further help, or for errata, corrections or things to add to this guide, please do contact me!
