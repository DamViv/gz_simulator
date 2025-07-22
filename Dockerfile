FROM osrf/ros:jazzy-desktop-full-noble

# ???
RUN DEBIAN_FRONTEND=noninteractive
#ENV DEBIAN_FRONTEND=noninteractive

# Libs and dependencies : git, ROS2, rviz2, gazebo, PCL, terminator, cmake, colcon, eigen ...
RUN apt-get update && apt upgrade -y && apt-get install -y \
    terminator \
    tmux -y \
    git-all -y \
    lsb-release -y \
    tmux -y \
    build-essential \
    cmake \
    git \
    libgtk2.0-dev \
    pkg-config \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev  \
    libgoogle-glog-dev \
    libatlas-base-dev \
    libeigen3-dev \
    libsuitesparse-dev \
    libabsl-dev \
    libpcl-dev \
    wget \
    x11-apps -y \
    ros-jazzy-rviz2 \
    ros-jazzy-ros-gz \
    ros-jazzy-cv-bridge \
    python3-colcon-common-extensions \
    ros-jazzy-tf-transformations \
    ros-jazzy-joint-state-publisher-gui	\
    && rm -rf /var/lib/apt/lists/* 


# Use root user & define working environment
USER root
RUN mkdir -p /root/ros_jazzy_ws
WORKDIR /root/ros_jazzy_ws

# ROS2 environment setting for root user
RUN echo "source /opt/ros/jazzy/setup.bash" >> /root/.bashrc
RUN echo "source /root/ros_jazzy_ws/install/setup.bash" >> /root/.bashrc
RUN echo "source /opt/ros/jazzy/setup.bash && cd /root/ros_jazzy_ws && colcon build"

RUN echo 'alias start_simu="ros2 launch rover_gz_bringup startSimulator.launch.py"' >> ~/.bashrc

ENV XDG_RUNTIME_DIR=/tmp

# Enter the docker in a terminal
RUN mkdir -p /root/.config/terminator
COPY ../terminatorLayout.txt /root/.config/terminator/config





