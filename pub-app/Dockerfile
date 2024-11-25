FROM almalinux:9.4
WORKDIR /app
COPY . .
RUN pip install -r requirements.txt
CMD ["python", "pub-app.py"]