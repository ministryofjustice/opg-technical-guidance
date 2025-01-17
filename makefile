# Update ROOT_DOCPATH to match your github pages site. By default, this will be
# /[repository name], e.g. for the repo ministryofjustice/technical-guidance
# this should be "/technical-guidance"

# You should never need to run this manually, because the github action should
# take care of publishing. see: .github/workflows/publish.yml
.PHONY: build
build:
	mkdir -p -m 0777 docs
	docker run --rm \
		-e ROOT_DOCPATH=$${ROOT_DOCPATH} \
		-v $$(pwd)/config.rb:/app/config.rb \
		-v $$(pwd)/config:/app/config \
		-v $$(pwd)/source:/app/source \
		-v $$(pwd)/docs:/app/docs \
		ministryofjustice/tech-docs-github-pages-publisher:v4.0.0 \
		/usr/local/bin/package

# Use this to run a local instance of the documentation site, while editing
.PHONY: preview
preview:
	docker run --rm --platform linux/amd64\
		-v $$(pwd)/config.rb:/app/config.rb \
		-v $$(pwd)/config:/app/config \
		-v $$(pwd)/source:/app/source \
		-p 4567:4567 \
		ministryofjustice/tech-docs-github-pages-publisher:v4.0.0 \
		/usr/local/bin/preview

run-structurizr-export:
	docker pull structurizr/cli:latest
	docker run --rm -v $(PWD)/dsl/poas:/usr/local/structurizr structurizr/cli \
	export -workspace /usr/local/structurizr/workspace.dsl -format mermaid
	rm $(PWD)/dsl/poas/*-key*

run-structurizr-export-plantuml:
	docker pull structurizr/cli:latest
	docker run --rm -v $(PWD)/dsl/poas:/usr/local/structurizr structurizr/cli \
	export -workspace /usr/local/structurizr/workspace.dsl -format plantuml
	rm $(PWD)/dsl/poas/*-key*

run-structurizr:
	docker pull structurizr/lite
	docker run -it --rm -p 8080:8080 -v $(PWD)/dsl/poas:/usr/local/structurizr structurizr/lite
