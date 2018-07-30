FROM ytqiu/redash-base:latest
USER root

# We first copy only the requirements file, to avoid rebuilding on every file
# change.

COPY requirements.txt requirements_dev.txt requirements_all_ds.txt ./

#RUN pip install -i https://pypi.doubanio.com/simple/ --upgrade pip
RUN pip install -i https://pypi.doubanio.com/simple/ -r requirements.txt -r requirements_dev.txt -r requirements_all_ds.txt

#RUN chown -R redash /app

COPY . ./
#RUN npm --registry https://registry.npm.taobao.org/ install
#RUN npm install
#RUN npm run build
RUN yarn
RUN yarn build

ENTRYPOINT ["/app/bin/docker-entrypoint"]

RUN chown -R redash /app
USER redash

CMD ["server"]
