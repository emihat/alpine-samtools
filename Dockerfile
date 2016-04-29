FROM alpine:3.2

MAINTAINER emihat <hattori.emi@imsbio.co.jp>

ENV SAMTOOLS_VERSION 1.3.1
ENV TABIX_VERSION 0.2.6

RUN apk add --update pcre-dev openssl-dev \
 && apk add --virtual build-dependencies build-base curl \
 && curl -L -o samtools-${SAMTOOLS_VERSION}.tar.bz2 \
    http://jaist.dl.sourceforge.net/project/samtools/samtools/${SAMTOOLS_VERSION}/samtools-${SAMTOOLS_VERSION}.tar.bz2 \
 && tar jxvf samtools-${SAMTOOLS_VERSION}.tar.bz2  \
 && cd samtools-${SAMTOOLS_VERSION}/ \
 && ./configure --without-curses \
 && make \
 && make install \
 && curl -L -o tabix-${TABIX_VERSION}.tar.bz2 \
    http://downloads.sourceforge.net/project/samtools/tabix/tabix-${TABIX_VERSION}.tar.bz2 \
 && tar jxvf tabix-${TABIX_VERSION}.tar.bz2  \
 && cd tabix-${TABIX_VERSION}/ \
 && make \
 && ln -sf /tabix-${TABIX_VERSION}/tabix /usr/local/bin/ \
 && apk del build-dependencies \
 && rm -rf /var/chache/apk/*

CMD ["samtools"]
