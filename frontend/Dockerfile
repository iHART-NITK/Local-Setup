FROM phusion/baseimage:0.9.19 as builder
RUN apt update && \
    apt-get -y install sudo
RUN apt install -y curl
RUN apt install -y git
RUN apt install -y unzip
RUN apt install -y xz-utils
RUN apt install -y zip
RUN apt install -y libglu1-mesa
 RUN apt install -y openjdk-8-jdk
RUN apt install -y wget
RUN useradd -ms /bin/bash user && \
    usermod -aG sudo user
# New added for disable sudo password
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER user
WORKDIR /app

#Installing Android SDK
RUN mkdir -p Android/sdk
ENV ANDROID_SDK_ROOT //app/Android/sdk
RUN mkdir -p .android && touch .android/repositories.cfg
RUN wget -O sdk-tools.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
RUN unzip sdk-tools.zip && rm sdk-tools.zip
RUN mv tools Android/sdk/tools
RUN cd Android/sdk/tools/bin && yes | ./sdkmanager --licenses
RUN cd Android/sdk/tools/bin && ./sdkmanager "build-tools;29.0.2" "patcher;v4" "platform-tools" "platforms;android-29" "sources;android-29"
ENV PATH "$PATH://app/Android/sdk/platform-tools"

#Installing Flutter SDK
RUN git clone https://github.com/flutter/flutter.git
ENV PATH "$PATH://app/flutter/bin"

RUN sudo apt-get update && \
    /app/flutter/bin/flutter channel master && \
    /app/flutter/bin/flutter upgrade

COPY pubspec.yaml /app/

RUN /app/flutter/bin/flutter pub get

COPY . /app/

RUN sudo touch /app/ios/Flutter/flutter_export_environment.sh && \
    sudo chown -R $(whoami) /app/ios/Flutter/flutter_export_environment.sh && \
    sudo touch /app/flutter/version && \
    sudo chown -R $(whoami) /app/flutter/version && \
    sudo touch /app/lib/generated_plugin_registrant.dar && \
    sudo chown -R $(whoami) /app/lib/generated_plugin_registrant.dar && \
    sudo touch /app/android/local.properties && \
    sudo chown -R $(whoami) /app/android/local.properties && \
    sudo touch /app/ios/Flutter/Generated.xcconfig && \
    sudo chown -R $(whoami) /app/ios/Flutter/Generated.xcconfig && \
    sudo mkdir /app/android/app/src/main/java/ && \
    sudo mkdir /app/android/app/src/main/java/io/ && \
    sudo mkdir /app/android/app/src/main/java/io/flutter/ && \
    sudo mkdir /app/android/app/src/main/java/io/flutter/plugins && \
    sudo touch /app/android/app/src/main/java/io/flutter/plugins/GeneratedPluginRegistrant.java && \
    sudo chown -R $(whoami) /app/android/app/src/main/java/io/flutter/plugins/GeneratedPluginRegistrant.java && \
    sudo touch /app/ios/Runner/GeneratedPluginRegistrant.h && \
    sudo chown -R $(whoami) /app/ios/Runner/GeneratedPluginRegistrant.h && \
    sudo touch /app/ios/Runner/GeneratedPluginRegistrant.m && \
    sudo chown -R $(whoami) /app/ios/Runner/GeneratedPluginRegistrant.m && \
    sudo touch /app/lib/generated_plugin_registrant.dart && \
    sudo chown -R $(whoami) /app/lib/generated_plugin_registrant.dart

RUN sudo chmod +x wait-for-it.sh
RUN sudo chmod +x frontend.sh

CMD ["./wait-for-it.sh", "backend:8000", "--", "sh", "./frontend.sh"]
