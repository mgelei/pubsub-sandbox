FROM almalinux:9.4
RUN python3 -m ensurepip --upgrade
WORKDIR /app
COPY . .
RUN python3 -m pip install -r requirements.txt
CMD ["python3", "pub-app.py"]