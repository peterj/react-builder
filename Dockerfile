FROM node

COPY . .
RUN chmod +x init.sh
RUN chmod +x build.sh

ENTRYPOINT ["/bin/bash"]
CMD ["init.sh"]