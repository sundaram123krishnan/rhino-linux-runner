FROM ubuntu:latest

USER root

COPY rhino-linux-runner.sh /rhino-linux-runner.sh

RUN chmod +x /rhino-linux-runner.sh

ENTRYPOINT ["/rhino-linux-runner.sh"]
