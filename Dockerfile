FROM jupyter/base-notebook:notebook-7.0.6

# Add a "USER root" statement followed by RUN statements to install system packages using apt-get,
# change file permissions, etc.
USER root

# Kotlin Jupyter requires Java 11 to be installed.
# See https://github.com/Kotlin/kotlin-jupyter/pull/394 and https://github.com/Kotlin/kotlin-jupyter/pull/394/commits/5ebb0b020fe8b9b2fb0173b3c1d2e45087f3f8bc
RUN apt-get update \
  && apt-get install -yq --no-install-recommends openjdk-11-jre

# If you do switch to root, always be sure to add a "USER $NB_USER" command at the end of the
# file to ensure the image runs as a unprivileged user by default.
USER $NB_UID

ENV JUPYTER_ENABLE_LAB=yes

COPY requirements.txt .

RUN pip install kotlin-jupyter-kernel -r requirements.txt
