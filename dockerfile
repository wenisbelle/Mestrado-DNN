FROM nvidia/cuda:12.1.1-base-ubuntu22.04

# Minimal setup
RUN apt-get update \
 && apt-get install -y locales lsb-release
ARG DEBIAN_FRONTEND=noninteractive
RUN locale-gen en_US en_US.UTF-8 && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG=en_US.UTF-8
SHELL [ "/bin/bash" , "-c" ]

# Install ROS2 Humble
RUN apt update \
 && apt install -y --no-install-recommends curl \
 && apt install -y --no-install-recommends gnupg2 \
 && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y net-tools gedit
 
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null

RUN apt-get update && apt install -y ros-humble-desktop

RUN apt-get install -y python3-rosdep \
 && apt-get install -y python3-colcon-common-extensions

RUN apt-get install -y git

RUN apt-get update

RUN apt-get install -y python3-pip \
    python3-dev 
    
RUN apt-get update && apt-get install -y ros-humble-librealsense2* \
                        ros-humble-realsense2-*

RUN source /opt/ros/humble/setup.bash
RUN mkdir -p /DDN/src
WORKDIR /DDN
COPY ./src /DDN/src

RUN cd /DDN/src/vggt && pip install -r requirements.txt && pip install -r requirements_demo.txt


RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc && \
    echo "source /DDN/install/setup.bash" >> ~/.bashrc
 
    


