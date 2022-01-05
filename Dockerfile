FROM jupyter/base-notebook:notebook-6.4.6

# Add a "USER root" statement followed by RUN statements to install system packages using apt-get,
# change file permissions, etc.
USER root

# Kotlin Jupyter requires Java 8 to be installed.
# See https://github.com/cheptsov/kotlin-jupyter-demo/blob/master/index.ipynb
RUN apt-get update \
  && apt-get install -yq --no-install-recommends openjdk-8-jre

# If you do switch to root, always be sure to add a "USER $NB_USER" command at the end of the
# file to ensure the image runs as a unprivileged user by default.
USER $NB_UID

ENV JUPYTER_ENABLE_LAB=yes

RUN conda install -c jetbrains kotlin-jupyter-kernel
