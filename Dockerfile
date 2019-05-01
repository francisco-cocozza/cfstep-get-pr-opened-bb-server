FROM codefresh/cli:latest
LABEL maintainer="francisco@codefresh.io"

COPY script/run.sh /run.sh
RUN cdmod +x /run.sh
ENTRYPOINT ["bash", "/run.sh" ]