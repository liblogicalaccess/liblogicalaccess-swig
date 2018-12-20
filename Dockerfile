FROM docker-registry.islog.com:5000/conan-recipes-support:cis-latest
RUN apt-get update
RUN (cd /root/.conan && wget http://conan.islog.private/artifactory/islog-generic/conan-profiles.zip && unzip conan-profiles.zip && rm conan-profiles.zip)

RUN apt-get install -y libpcre3-dev
RUN apt-get install -y bison
RUN apt-get install -y libclang-6.0-dev

RUN (cd /opt && git clone --depth 1 https://github.com/swig/swig.git)
RUN (cd /opt/swig && ./autogen.sh && ./configure && make -j5 && make install)

# Install Dotnet core from Microsoft
RUN (cd /opt && wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.asc.gpg)
RUN (cd /opt && mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/)
RUN (cd /opt && wget -q https://packages.microsoft.com/config/debian/9/prod.list)
RUN (cd /opt && mv prod.list /etc/apt/sources.list.d/microsoft-prod.list)
RUN (cd /opt && chown root:root /etc/apt/trusted.gpg.d/microsoft.asc.gpg)
RUN (cd /opt && chown root:root /etc/apt/sources.list.d/microsoft-prod.list)
RUN apt-get update
RUN apt-get install -y dotnet-sdk-2.2
