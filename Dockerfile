# Base ROS image
FROM ros:noetic-ros-core

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install locales and set UTF-8
RUN apt-get update && apt-get install -y \
    locales

# Generate locale
RUN locale-gen en_US en_US.UTF-8

# Set locale environment variables
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# Install dependencies and Pinocchio
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    ros-noetic-dynamic-reconfigure \
    libeigen3-dev \
    ros-noetic-plotjuggler-ros \
    ros-noetic-pinocchio \
    cmake
    
# Install ROS2 Foxy
RUN apt-get update && apt-get install -y \
    curl \
    gnupg2 \
    lsb-release \
    software-properties-common

# Add ROS2 Foxy repository
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

# Install ROS2 Foxy Base
RUN apt-get update && apt-get install -y \
    ros-foxy-ros-base \
    python3-colcon-common-extensions \
    python3-rosdep \
    python3-argcomplete

# Initialize rosdep
RUN rosdep init && rosdep update


# (Optional) Source ROS environment automatically
SHELL ["/bin/bash", "-c"]
# RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
# RUN echo "source /opt/ros/foxy/setup.bash" >> ~/.bashrc


