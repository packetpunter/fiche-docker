FROM ubuntu:latest
ENV WORKDIR /app/tricorder
ENV ACCESSIBLE_WEB_IP 10.2.0.3
WORKDIR ${WORKDIR}
ADD ./addins/tricorder/* /app/tricorder/
ADD ./addins/run_nginx.sh /app
RUN apt -y update; apt -y upgrade; apt -y install gcc make automake
RUN make; make install
RUN apt -y install python3 python3-pip; python3 -m pip install ansi2html; apt -y install nginx; chmod +x /app/run_nginx.sh
RUN echo "fiche -d ${ACCESSIBLE_WEB_IP}:10080 -o /var/www/html -s 6 -B 1536000" >> /app/run_nginx.sh
CMD ["/app/run_nginx.sh"]
