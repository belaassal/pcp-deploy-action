
# Container image
FROM alpine:3.11

# Copies code file from action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

#Make  entrypoint.sh executable:
RUN chmod 777 entrypoint.sh

RUN apk update
RUN apk add --no-cache openssh


#File to execute when container starts up 
ENTRYPOINT ["/entrypoint.sh"]