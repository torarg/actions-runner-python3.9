FROM docker.io/python:3.9-alpine
RUN adduser -D app

ADD actions-runner-linux-*.tar.gz /home/app/actions-runner
COPY entrypoint.sh /home/app/entrypoint.sh
RUN chown -R app:app /home/app && \
  apk add curl git unzip sudo jq bash openssl gcompat nodejs tar && \
  apk add aspnetcore7-runtime uuidgen && \
  apk add build-base musl-dev linux-headers && \
  rm /home/app/actions-runner/externals/node16/bin/node && ln -s /usr/bin/node /home/app/actions-runner/externals/node16/bin/node && \
  rm /home/app/actions-runner/externals/node20/bin/node && ln -s /usr/bin/node /home/app/actions-runner/externals/node20/bin/node


ENV RUNNER_MANUALLY_TRAP_SIG=1
ENV ACTIONS_RUNNER_PRINT_LOG_TO_STDOUT=1

WORKDIR /home/app
USER app
CMD ["/home/app/entrypoint.sh"]
