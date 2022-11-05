
# Tweak the base image by installing pipenv
FROM python:3.10 as base
RUN pip install pipenv

# Begin our actual build
FROM base as base1

RUN mkdir -p /usr/src/app

COPY ./_app /usr/src/app
COPY Pipfile /usr/src/app/
COPY Pipfile.lock /usr/src/app/

WORKDIR /usr/src/app

COPY api/requirements.txt ./

RUN pipenv install --system --deploy
RUN python manage.py collectstatic --no-input