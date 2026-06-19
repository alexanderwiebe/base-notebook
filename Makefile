setup:
	pip install '.[dev]' && pre-commit install

init:
	python scripts/init_template.py

jupyter:
	jupyter lab --IdentityProvider.token=$${JUPYTER_TOKEN:-dev} --no-browser --port=8888
