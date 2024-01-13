# Use manylinux_2_28 image
FROM quay.io/pypa/manylinux_2_28_aarch64 as build

RUN yum -y install gcc make patch zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel tk-devel libffi-devel xz-devel jq
RUN curl https://pyenv.run | bash
ENV PATH="/root/.pyenv/bin:/root/.pyenv/shims:${PATH}"
RUN pyenv install 3.12
RUN pyenv global 3.12
RUN python --version

RUN pip install --upgrade pip setuptools wheel

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

ARG OSO_VERSION
WORKDIR /opt
RUN git clone --depth 1 --branch "v$OSO_VERSION" https://github.com/osohq/oso.git /opt/oso
WORKDIR /opt/oso
RUN rm -Rf .git
RUN make python-build
RUN make python-test
WORKDIR /opt/oso/languages/python/oso
RUN python setup.py bdist_wheel
RUN auditwheel repair dist/*.whl -w wheelhouse/

WORKDIR /opt/oso
RUN make python-django-build
RUN make python-django-test
WORKDIR /opt/oso/languages/python/django-oso
RUN python setup.py bdist_wheel
# RUN auditwheel repair dist/*.whl -w wheelhouse/

FROM scratch as runtime
ARG OSO_VERSION
COPY --from=build /opt/oso/languages/python/oso/wheelhouse/oso-"$OSO_VERSION"-cp312-cp312-manylinux_2_28_aarch64.whl /
COPY --from=build /opt/oso/languages/python/django-oso/dist/django_oso-0.27.1-py3-none-any.whl /