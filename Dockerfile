FROM nexilo/symfony4_fpm:latest

MAINTAINER Kamil Bednarek <kamil@nexilo.uk>

RUN apt-get install -y nodejs build-essential libcairo2-dev libjpeg-dev libpango1.0-dev libgif-dev inotify-tools curl
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y yarn

ADD /scripts/command.sh /command.sh
RUN chmod +x /command.sh

CMD ["/command.sh"]
