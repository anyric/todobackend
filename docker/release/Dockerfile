FROM anyric/todobackend-docker-image:latest
MAINTAINER Anyama Richard

# Copy application artifacts
COPY target /wheelhouse

# Install application and dependencies
RUN . /appenv/bin/activate && \
  pip install --no-index -f /wheelhouse todobackend && \
  rm -rf /wheelhouse

