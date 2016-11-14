FROM node:6.9.1

# https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz



# Base OS and runtime environments
RUN \
     apt-get update \
  && apt-get install -y \
       openjdk-7-jdk

# Android Tools
ENV \
  ANDROID_SDK_VERSION=24.4.1 \
  ANDROID_HOME=/opt/android-sdk-linux
ENV \
  PATH=$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH
RUN \
     cd /opt \
  && ANDROID_SDK_ARCHIVE=android-sdk_r${ANDROID_SDK_VERSION}-linux.tgz \
  && wget -q https://dl.google.com/android/${ANDROID_SDK_ARCHIVE} \
  && tar xzf ${ANDROID_SDK_ARCHIVE} \
  && rm ${ANDROID_SDK_ARCHIVE}

# Android SDKs and Tools
COPY android_sdk_install.sh /opt
RUN \
     echo "Updating Android SDK installation index..." \
  && /opt/android_sdk_install.sh "Android SDK Platform-tools, revision 25" \
  && /opt/android_sdk_install.sh "SDK Platform Android 7.0, API 24, revision 2" \
  && rm -f /opt/android_sdk_install.sh

# React Native Tools
RUN \
     npm install -g react-native-cli

# Fix up permissions
RUN chown -R root:root /opt && chmod +x $ANDROID_HOME/tools/android

RUN \
     adduser \
       --disabled-password \
       --shell /bin/bash \
       --gecos "App User" \
       app \
  && mkdir /home/app/.gradle \
  && mkdir /home/app/.npm \
  && mkdir /app \
  && chown -R app:app /home/app \
  && chown -R app:app /app

WORKDIR /app
USER app
