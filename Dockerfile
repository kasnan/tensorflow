# FROM ubuntu:20.04
FROM nvidia/cuda:10.2-cudnn8-devel-ubuntu18.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Seoul
ENV CUDA_VER=10.2

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y \
    build-essential pkg-config software-properties-common \
    lsb-release \
    sudo unzip wget curl nano \
    git git-core git-flow \
    gcc g++ make \
    vim tmux zsh \
    python3-pip;

RUN sudo apt install -y cmake meson ninja-build;

RUN useradd --create-home --shell /bin/zsh kdh
RUN usermod --append --groups sudo kdh
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER kdh

WORKDIR /home/kdh

RUN sudo apt-get install -y \
    x11vnc xvfb && \
    mkdir ~/.vnc && \
    touch ~/.vnc/passwd;

RUN x11vnc -storepasswd "kasnan9847!" ~/.vnc/passwd

CMD ["/bin/zsh"]