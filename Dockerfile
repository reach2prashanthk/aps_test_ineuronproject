# Use the official Python 3.8 image as the base image
FROM python:3.8

# Switch to root user
USER root

# Create a directory called /app in the container
RUN mkdir /app

# Copy the contents of the ./app/ directory from the host into the /app/ directory in the container
COPY ./app/ /app/

# Set the working directory to /app/
WORKDIR /app/

# Install Python dependencies from requirements.txt
RUN pip3 install -r requirements.txt

# Set environment variables
ENV AIRFLOW_HOME='/app/airflow'
ENV AIRFLOW_CORE_DAGBAG_IMPORT_TIMEOUT=1000
ENV AIRFLOW_CORE_ENABLE_XCOM_PICKLING=True

# Create an Airflow user and set permissions
RUN airflow users create -e reach2prashanthk@gmail.com -f prashanth -l k -p admin -r Admin -u admin

# Change permissions for the start script
RUN chmod 777 start.sh

# Update package list and install AWS CLI
RUN apt update -y && apt install awscli -y

# Set the default entrypoint and command for the container
ENTRYPOINT [ "/bin/sh" ]
CMD ["start.sh"]
