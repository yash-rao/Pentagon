# Use Debian as the base image
FROM debian:latest

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

# Update and install common dependencies for all tools
RUN apt-get update && \
    apt-get install -y wget apt-transport-https libstdc++6 libpython3.10 unzip openjdk-17-jdk python3 python3-pip vim tar tzdata git automake autoconf libtool libleptonica-dev pkg-config zlib1g-dev make g++ openjdk-17-jdk-headless gdb curl libreoffice-writer libreoffice-calc libreoffice-impress unpaper ocrmypdf procps genisoimage jq mesa-utils pciutils qemu-system socat spice-client-gtk usbutils uuid-runtime x11-xserver-utils xdg-user-dirs zsync && \
    apt-get clean && rm -rf /var/lib/apt/lists/*


# Install BinDiff
RUN apt-get update && \
    apt-get install -y wget apt-transport-https libstdc++6 libpython3.10 && \
    wget https://github.com/google/bindiff/releases/download/v8/bindiff_8_amd64.deb && \
    apt-get install -y ./bindiff_8_amd64.deb && \
    rm -f bindiff_8_amd64.deb && \
    apt-get clean

# Install Quickemu
RUN wget https://github.com/quickemu-project/quickemu/releases/download/4.9.6/quickemu_4.9.6-1_all.deb && \
    apt-get install -y ./quickemu_4.9.6-1_all.deb && \
    rm -f quickemu_4.9.6-1_all.deb && \
    apt-get clean

# Set environment variables
ENV GHIDRA_INSTALL_DIR /opt/ghidra
ENV JAVA_HOME /usr/lib/jvm/java-17-openjdk-amd64
ENV PATH $JAVA_HOME/bin:$PATH

# Download and install Ghidra
RUN wget https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_11.1.2_build/ghidra_11.1.2_PUBLIC_20240709.zip -O /tmp/ghidra.zip && \
    unzip /tmp/ghidra.zip -d /opt && \
    mv /opt/ghidra_11.1.2_PUBLIC /opt/ghidra && \
    rm /tmp/ghidra.zip

# Set Ghidra environment variable
ENV GHIDRA_INSTALL_DIR /opt/ghidra

# Install ghidrecomp Python package
RUN pip3 install ghidrecomp --break-system-packages

# Install Stirling-PDF dependencies and tools
RUN pip3 install --no-cache-dir uno opencv-python-headless unoconv pngquant WeasyPrint --break-system-packages

# Install GEF (GDB Enhanced Features)
RUN bash -c "$(curl -fsSL https://gef.blah.cat/sh)" && \
    echo "source ~/.gef.rc" >> ~/.gdbinit

# Clone and build jbig2enc (required for certain OCR functionality in Stirling-PDF)
RUN mkdir -p ~/.git && cd ~/.git && \
    git clone https://github.com/agl/jbig2enc.git && \
    cd jbig2enc && \
    ./autogen.sh && \
    ./configure && \
    make && \
    make install

# Clone and build Stirling-PDF
RUN cd ~/.git && \
    git clone https://github.com/Stirling-Tools/Stirling-PDF.git && \
    cd Stirling-PDF && \
    chmod +x ./gradlew && \
    ./gradlew build

# Move Stirling-PDF JAR and scripts to /opt/Stirling-PDF
RUN mkdir -p /opt/Stirling-PDF && \
    mv ~/.git/Stirling-PDF/build/libs/Stirling-PDF-0.29.0.jar /opt/Stirling-PDF/ && \
    mv ~/.git/Stirling-PDF/scripts /opt/Stirling-PDF/ && \
    echo "Stirling-PDF and scripts installed."

# Expose ports for Stirling-PDF and GEF
EXPOSE 8080
EXPOSE 1234

# Set the working directory to Ghidra
WORKDIR /opt/ghidra

# Set default command to bash with flexibility to run other tools
CMD ["/bin/bash"]
