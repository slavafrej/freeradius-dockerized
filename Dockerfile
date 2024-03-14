FROM ubuntu:22.04
LABEL maintainer="root@slavafrej.ru"

RUN ["apt", "update"]
RUN ["apt", "install", "freeradius", "-y"]
WORKDIR /etc/freeradius/3.0/certs
COPY ./ca.cnf .
COPY ./server.cnf .
RUN ["make", "ca.der"]
RUN ["make", "server.pem"]
COPY ./clients.conf /etc/freeradius/3.0/.
COPY ./radiusd.conf /etc/freeradius/3.0/.
COPY ./authorize /etc/freeradius/3.0/mods-config/files/.
RUN ["chown", "freerad:freerad", "-R", "/etc/freeradius/3.0"]
EXPOSE 1812
EXPOSE 1813

CMD ["freeradius", "-X"]
