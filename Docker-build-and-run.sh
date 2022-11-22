#!/bin/zsh 

# Here are the steps to build a Docker image that can run conda and bioconda for doing my computational biology work with miniconda python tools
# Copy each line, paste and run in the 'native' (arm64) terminal one-by-one

# Change to folder where you want to mount the image
cd "~/Desktop/M1_Docker_bioconda"

# Docker commands to build the environment -- can take hours -- only do once
# docker build -f Dockerfile --platform linux/amd64 -m 14g --pull -t compbio_conda/python_envs .

# start XQuartz if using Spyder
# Run the following command
xhost +

# Run Docker container with XWindows support
# This version will save the container and I can 'resume' it later and it will 'save' the current state upon exit
docker run --platform linux/amd64 \
    -i -t \
    -p 8888:8888 \
    -v ${HOME}/Documents:/home/ \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e DISPLAY="host.docker.internal:0" \
    -e HHHOME="${HOME}" \
    compbio_conda/python_envs

# To access juypter notebook, activate base environment and use the following line:
jupyter notebook --ip 0.0.0.0 --no-browser --allow-root # Then use the link output at terminal in browser window

# Now to end this, exit from the docker container then run container ID is the SHA for container
container_ID="[copy and paste in container ID here]"

# To 'resume' where you left off in the container, use the following (remember to stop at the end)
docker restart $container_ID
docker attach $container_ID

# Stop when done
docker stop $container_ID

## Run Docker container with XWindows support that automatically deletes itself
## --rm will remove the container as soon as it ends
# docker run --rm --platform linux/amd64 \
#     -i -t \
#     -v ${HOME}/Documents:/home/ \
#     -v /tmp/.X11-unix:/tmp/.X11-unix \
#     -e DISPLAY="host.docker.internal:0" \
#     -e HHHOME="${HOME}" \
#     compbio_conda/python_envs

## To export the environment yaml files so they can be recreated in another container
# conda env export > base_environment.yml
# conda activate deeptools
# conda env export > deeptools_environment.yml
# conda deactivate
