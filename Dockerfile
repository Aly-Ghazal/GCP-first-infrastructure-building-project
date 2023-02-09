# from base image python
FROM python:3.7-alpine

# create directory /app and make it as working dirrectory
WORKDIR /app 

# copy requirements content to /app
COPY requirements.txt /app

# install dependencies from requirements.txt
RUN pip3 install --no-cache-dir -r requirements.txt

# copy the app content to /app
COPY . /app

# run app
CMD  python3 hello.py

#sudo docker build --no-cache . -t alyghazal22/simpleapp:v1.2
#sudo docker tag alyghazal22/simpleapp:v1.2 us.gcr.io/aly-ahmed-gcp-project/alyghazal22/simpleapp:v1.2
#sudo docker push  us.gcr.io/aly-ahmed-gcp-project/alyghazal22/simpleapp:v1.2