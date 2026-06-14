SHELL := /bin/zsh

TF_STACKS := \
	live/bootstrap/state-bucket \
	live/bootstrap/prod-state-bucket \
	live/dev/global/project-services \
	live/dev/global/service-accounts \
	live/dev/us-central1/artifact-registry \
	live/dev/us-central1-a/gke-cluster \
	live/prod/global/project-services \
	live/prod/global/service-accounts \
	live/prod/us-central1/network \
	live/prod/us-central1/artifact-registry \
	live/prod/us-central1-a/gke-cluster

TF_MODULES := \
	modules/gcp/project-services \
	modules/gcp/service-account \
	modules/gcp/artifact-registry \
	modules/gcp/gke-cluster

.PHONY: tf-fmt tf-validate tf-init-all tf-plan tf-apply

tf-fmt:
	terraform fmt -recursive

tf-validate:
	@for dir in $(TF_MODULES) $(TF_STACKS); do \
		echo "==> $$dir"; \
		env -u GOOGLE_APPLICATION_CREDENTIALS terraform -chdir=$$dir init -backend=false -reconfigure >/dev/null; \
		env -u GOOGLE_APPLICATION_CREDENTIALS terraform -chdir=$$dir validate; \
	done

tf-init-all:
	@for dir in $(TF_STACKS); do \
		echo "==> $$dir"; \
		env -u GOOGLE_APPLICATION_CREDENTIALS terraform -chdir=$$dir init; \
	done

tf-plan:
	@test -n "$(STACK)" || (echo "Usage: make tf-plan STACK=live/dev/..." && exit 1)
	env -u GOOGLE_APPLICATION_CREDENTIALS terraform -chdir=$(STACK) plan

tf-apply:
	@test -n "$(STACK)" || (echo "Usage: make tf-apply STACK=live/dev/..." && exit 1)
	env -u GOOGLE_APPLICATION_CREDENTIALS terraform -chdir=$(STACK) apply
