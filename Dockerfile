FROM tensorflow/tensorflow:latest-jupyter


# Add user ubuntu with no password, add to sudo group
RUN adduser --disabled-password --gecos '' ubuntu
RUN adduser ubuntu sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER ubuntu
WORKDIR /home/ubuntu/
RUN chmod a+rwx /home/ubuntu/
#RUN echo `pwd`

RUN pip install --upgrade pip

RUN pip install numpy
RUN pip install scipy
RUN pip install pandas
RUN pip install matplotlib
RUN pip install seaborn
RUN pip install scikit-learn


# Configuring access to Jupyter
RUN mkdir /home/ubuntu/notebooks
RUN jupyter notebook --generate-config --allow-root
#RUN echo "c.NotebookApp.password = u'sha1:6a3f528eec40:6e896b6e4828f525a6e20e5411cd1c8075d68619'" >> #/home/ubuntu/.jupyter/jupyter_notebook_config.py



# Jupyter listens port: 8888
EXPOSE 8888

# Run Jupyter notebook as Docker main process
CMD ["jupyter", "notebook", "--allow-root", "--NotebookApp.token=''", "--NotebookApp.password=''","--notebook-dir=/home/ubuntu/notebooks", "--ip='*'", "--port=8888", "--no-browser"]