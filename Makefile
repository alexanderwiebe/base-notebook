setup:
	pip install '.[dev]' && pre-commit install

init:
	python scripts/init_template.py

jupyter:
	jupyter lab --IdentityProvider.token=$${JUPYTER_TOKEN:-dev} --no-browser --port=8888

mcp-server:
	jupyter-mcp-server start --transport=streamable-http --port=4040 --mcp-token=$${JUPYTER_TOKEN:-dev} --jupyter-url=http://localhost:8888 --jupyter-token=$${JUPYTER_TOKEN:-dev}
