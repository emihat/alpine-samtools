FROM alpine:3.2

MAINTAINER emihat <hattori.emi@imsbio.co.jp>

ENV SAMTOOLS_VERSION 1.3.1

RUN apk add --update pcre-dev openssl-dev \
 && apk add --virtual build-dependencies build-base curl \
 && curl -L -o samtools-${SAMTOOLS_VERSION}.tar.bz2 \
    http://jaist.dl.sourceforge.net/project/samtools/samtools/${SAMTOOLS_VERSION}/samtools-${SAMTOOLS_VERSION}.tar.bz2 \
 && tar jxvf samtools-${SAMTOOLS_VERSION}.tar.bz2  \
 && cd samtools-${SAMTOOLS_VERSION}/ \
 && ./configure --without-curses \
 && make \
 && make install \
 && apk del build-dependencies \
 && rm -rf /var/chache/apk/*

CMD ["samtools"]
