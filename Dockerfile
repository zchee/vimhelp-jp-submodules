FROM ubuntu:wily
MAINTAINER zchee <k@zchee.io>

# Copy all current directory
COPY . /usr/src/doc

# Install dependency packages
# Generate vim helptags use update.vim
RUN set -ex \
	&& sed -i 's/http:\/\/archive.ubuntu.com\/ubuntu/mirror:\/\/mirrors.ubuntu.com\/mirrors.txt/g' /etc/apt/sources.list \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends \
		git vim \
	\
	&& cd /usr/src/doc \
	&& git submodule update --init -f \
	\
	&& vim -c "source %" -c "qa!" -- update.vim >/dev/null

# Volume share /usr/src/doc directory
VOLUME /usr/src/doc
CMD ["/bin/bash"]
