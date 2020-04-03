FROM nginx:1.17.9
# for health check
RUN apt-get update && apt-get install -y curl 
ADD custom.conf /etc/nginx/conf.d
RUN echo "prepare to run nginx..."
CMD /usr/sbin/nginx -g 'daemon off;'
EXPOSE 80