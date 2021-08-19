# kotlin-notebook

[![Build, test, and publish Docker Images](https://github.com/knonm/kotlin-notebook/actions/workflows/default.yml/badge.svg)](https://github.com/knonm/kotlin-notebook/actions/workflows/default.yml)
[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/knonm/kotlin-notebook/main)

kotlin-notebook is a [Jupyter Docker Stack](https://github.com/jupyter/docker-stacks) image with the [Kotlin kernel for Jupyter/IPython](https://github.com/Kotlin/kotlin-jupyter).

This image includes:
- Jupyter Docker Stack (`jupyter/base-notebook` image);
- Kotlin Kernel for Jupyter;
- Java 8 (so the Kotlin Kernel can run properly).

# Usage

You can start using it straight out of the box with this "one"-liner:

```bash
docker run -it --rm \
  --name kotlin_notebook \
  -v ${PWD}:/home/jovyan/workspace \
  -p 8888:8888 \
  -e JUPYTER_ENABLE_LAB=yes \
  -e CHOWN_HOME=yes \
  knonm/kotlin-notebook:latest
```

Then open http://localhost:8888 to try it out.

# Links

- [Docker Hub repo](https://hub.docker.com/r/knonm/kotlin-notebook)
- [jupyter/base-notebook](https://jupyter-docker-stacks.readthedocs.io/en/latest/using/selecting.html#jupyter-base-notebook)
- [Kotlin Jupyter Demo](https://github.com/cheptsov/kotlin-jupyter-demo/blob/master/index.ipynb)
