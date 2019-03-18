FROM anyric/todobackend-docker-image:latest
MAINTAINER Anyama Richard

# Install dev/build dependencies
RUN apt-get update && apt-get install -qy python3-dev default-libmysqlclient-dev

# Activate virtualenv and install wheel support
RUN . /appenv/bin/activate && \
  pip install wheel --upgrade

# Pip environment variables after wheel installation
ENV WHEELHOUSE=/wheelhouse PIP_WHEEL_DIR=/wheelhouse PIP_FIND_LINKS=/wheelhouse XDG_CACHE_HMOE=/cache

# Output: build artifacts
VOLUME ["/wheelhouse", "/build", "/reports"]

# Add test environment variables
COPY scripts/test.sh /usr/local/bin/test.sh
RUN chmod +x /usr/local/bin/test.sh

# Copy application source to image
COPY src/ /application
WORKDIR /application

# Set default entrypoint scripts
ENTRYPOINT ["test.sh"]
CMD ["python", "manage.py", "test", "--noinput"]


