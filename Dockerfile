FROM python:3.13.2-alpine

ENV PYTHONFAULTHANDLER=1 \
  PYTHONUNBUFFERED=1 \
  PYTHONHASHSEED=random \
  PIP_NO_CACHE_DIR=off \
  PIP_DISABLE_PIP_VERSION_CHECK=on \
  PIP_DEFAULT_TIMEOUT=100

RUN pip install poetry==2.0.1

WORKDIR /code

COPY /ballsdex/poetry.lock /ballsdex/pyproject.toml ./
RUN touch README.md

RUN poetry config virtualenvs.create false && poetry install --no-interaction --no-ansi --no-root && rm -rf $POETRY_CACHE_DIR

COPY ballsdex ./

RUN poetry config virtualenvs.create false && poetry install --no-interaction --no-ansi

# wait for postgres to be ready
# CMD ["sleep", "1"]
# replaced with depends-on