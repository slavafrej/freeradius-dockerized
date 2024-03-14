FROM ubuntu:22.04
LABEL maintainer="root@slavafrej.ru"

RUN ["apt", "update"]
RUN ["apt", "install", "freeradius", "-y"]
COPY ./clients.conf /etc/freeradius/3.0/.
COPY ./radiusd.conf /etc/freeradius/3.0/.
COPY ./users /etc/freeradius/3.0/.

EXPOSE 1812
EXPOSE 1813

CMD ["freeradius", "-X"]
