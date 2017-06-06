FROM ruby:2.4

RUN curl -sL https://deb.nodesource.com/setup_7.x | bash -
RUN apt-get update && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  bison

RUN mkdir -p /programs
WORKDIR /programs
RUN git clone https://github.com/rubyomr-preview/ruby.git --branch ruby_2_4_omr --recursive && \
		cd ruby && autoconf && ./configure SPEC=linux_x86-64 --with-omr-jit && \
		make && make install


RUN mkdir -p /app
WORKDIR /app

RUN npm install -g yarn phantomjs-prebuilt

EXPOSE "5000:5000"
EXPOSE "8080:8080"

COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 20 --retry 5