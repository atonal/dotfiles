# Kill all running containers.
alias dkillall='docker kill $(docker ps -q)'

# Delete all stopped containers.
alias dcleanc='printf "\n>>> Deleting stopped containers\n\n" && docker rm $(docker ps -a -q)'

# Delete all untagged images.
alias dcleani='printf "\n>>> Deleting untagged images\n\n" && docker rmi $(docker images -q -f dangling=true)'

# Delete all stopped containers and untagged images.
alias dclean='dcleanc || true && dcleani'

# ctop
alias ctop='docker run --rm -ti --name=ctop -v /var/run/docker.sock:/var/run/docker.sock quay.io/vektorlab/ctop:latest'

# print current git branch name
alias bn='git rev-parse --abbrev-ref HEAD'

alias watchgit='watch -c -n 0,5 git -c color.ui=always lga'
