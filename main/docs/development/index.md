# Developement

## Shell

### Bash

```bash
set -x # Enable debug bash script
set +x # Disable debug bash script
```

### Awk

#### Cut column

```bash
ls -alh | awk -F '-' '{ print $1,$7}'
```

### Grep

#### Recursively with filename

```bash
grep -R "search text" --include "filename.ext"
```

### Perl

Replace between markup

```bash
    # http://superuser.com/questions/440013/how-to-replace-part-of-a-text-file-between-markers-with-another-text-file
    newContent=$(cat src/filename)
    sudo perl -0777 -i -pe "s/(### BEGIN MARKUP\\n).*(\\n### END MARKUP)/\$1$newContent\n\$2/s" dst/filename
```


## Python

### Pip

Install the git package version

    # From command line
    pip install git+https://github.com/username/project.git@branchname
    # in the requirement file
    -e git+https://github.com/username/projecyt.git@branchname#egg=project
    
### print

Print without return line
```python
print('.',end="",flush=True)
```

## Git

### Status
    # Ignore untracked files
    git config status.showuntrackedfiles no

### Commit

#### Cancel commit
    git reset HEAD~1

#### Delete files

##### Valid deleted file with rm
    git ls-files --deleted -z | xargs -0 git rm

##### Delete file from Git repository
    git reset HEAD filename/directoryname

### Branchs

#### Reset branch
    git checkout mybranch
    git reset --hard origin/mybranch

#### Delete local branch
    git branch -d the_local_branch
    git branch -D the_local_branch # Force

#### Delete remote branch
    git push origin :the_remote_branch

#### Rename branch or move branch
    git branch -m oldbranch newbranch

### Commit
### Configuration

#### Display log commit
In you git `.gitconfig`

    # In .gitconfig
    [alias]
    lg1 = log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all
    lg2 = log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all
    lg = !"git lg1"

#### Rebase by default when doing git pull 
    git config --global pull.rebase true


## Github
### Reset Github fork

    #http://scribu.net/blog/resetting-your-github-fork.html
    git remote add upstream git://github.com/wp-cli/wp-cli.git
    git fetch upstream
    git branch backup
    git checkout upstream/master -B master
    git push --force

## Mkdocs & Github

### Installation

    pip install mkdocs
    
### Configuration

Create documentation project with
    
    mkdocs new mydocs
    
You can see the result in the mydocs folder

    |-- mydocs              # Root mkdocs directory
        |-- index.md        # File documentation
    |-- mkdocs.yml          # config file
       
Edit you `mkdocs.yml`    
    
```no-highlight
pages:
- 'index.md'
```

Edit the `index.md` document with markdown syntax.

Now you can see your modification with `mkdocs serve` http://localhost:8000

### Deploy to github

### Prepare Github project (First time)
    
    git clone github.com/user/repository.git
    cd repository
    mkdocs gh-deploy --clean
    
### Push the documentation

After updated your documentation, you can push to github

    mkdocs gh-deploy
