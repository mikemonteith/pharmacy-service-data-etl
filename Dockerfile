FROM node:8.9.4-alpine

ENV USERNAME nodeuser

RUN adduser -D "$USERNAME" && \
    mkdir -p /code/output && \
    chown "$USERNAME":"$USERNAME" /code

USER $USERNAME
WORKDIR /code

ENV SYNDICATION_API_KEY=${SYNDICATION_API_KEY}
ENV AZURE_STORAGE_CONNECTION_STRING=${AZURE_STORAGE_CONNECTION_STRING}
ENV CONTAINER_NAME=${CONTAINER_NAME}

COPY yarn.lock package.json /code/
RUN if [ "$NODE_ENV" == "production" ]; then yarn install --production --pure-lockfile; else yarn install --pure-lockfile; fi

COPY . /code

USER root
RUN find /code -user 0 -print0 | xargs -0 chown "$USERNAME":"$USERNAME"

CMD [ "node", "schedule" ]
