FROM codefresh/cli:latest
LABEL maintainer="francisco@codefresh.io"

COPY script/run.sh /run.sh
RUN chmod +x /run.sh
ENTRYPOINT ["bash", "/run.sh" ]