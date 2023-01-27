FROM cirrusci/flutter

COPY ./ /app
WORKDIR /app
##USER ROOT
RUN rm -f .packages
RUN flutter pub get
RUN flutter clean
RUN flutter build apk

RUN mkdir /Mobile/
RUN cp build/app/outputs/apk/release/app-release.apk /Mobile/client.apk

RUN cp /Mobile/client.apk ./apk