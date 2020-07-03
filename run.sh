
user_name="torii"
directory_path=""
docker run --runtime=nvidia \
    -v /home/$user_name/Workspace/pybullet_docker/share/Desktop:/home/ubuntu/Desktop \
    -v /home/$user_name/Workspace/pybullet_docker/share/Workspace:/home/ubuntu/Workspace \
    --name ub18_deep_learning \
    -it ubuntu18:deep_learning
