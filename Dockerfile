FROM ubuntu:wily
MAINTAINER zchee <k@zchee.io>

# Copy all current directory

# Install dependency packages
# Generate vim helptags use update.vim
RUN set -ex \
	&& sed -i 's/http:\/\/archive.ubuntu.com\/ubuntu/http:\/\/ubuntutym.u-toyama.ac.jp\/ubuntu/g' /etc/apt/sources.list \
	&& apt-get update \
	&& apt-get install -y \
		git vim \
	\
	&& git clone https://github.com/zchee/vimhelp-jp-submodules.git /usr/src/doc \
	&& cd /usr/src/doc \
	&& git submodule update --init --force \
	&& git remote set-url origin git@github.com:zchee/vimhelp-jp-submodules.git \
	\
	&& vim -c "source %" -c "qa!" -- update.vim >/dev/null

# Volume share /usr/src/doc directory
VOLUME /usr/src/doc
CMD ["/bin/bash"]
