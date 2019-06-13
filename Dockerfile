FROM runatlantis/atlantis:0.5.0

RUN set -ex \
	&& apk add --no-cache py-pip build-base python-dev libffi-dev openssl-dev \
	&& pip install --upgrade pip \
	&& pip install ansible \
	&& apk del build-base py-pip libffi-dev openssl-dev

RUN set -ex \
	&& apk add --no-cache jq

RUN set -ex \
	apk update \
	&& apk add bash py-pip \
	&& apk add --virtual=build gcc libffi-dev musl-dev openssl-dev python-dev make \
	&& pip install azure-cli \
	&& apk del --purge build 

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["server", "--allow-repo-config"]