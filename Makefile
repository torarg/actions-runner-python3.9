COMPONENT_NAME = actions-runner-python3.9
DOCKERHUB_USER = torarg
DOCKERHUB_REPO = docker.io/${DOCKERHUB_USER}/${COMPONENT_NAME}
RUNNER_VERSION = 2.311.0
RUNNER_URL = https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

build:
	wget -q ${RUNNER_URL}
	podman build -t ${COMPONENT_NAME}:{VERSION} -f Dockerfile
	podman tag python3.9-runner:{VERSION} ${DOCKERHUB_REPO}:${VERSION}
	podman tag python3.9-runner:{VERSION} ${DOCKERHUB_REPO}:latest
	rm ./actions-runner-*.tar.gz

publish:
	podman push ${DOCKERHUB_REPO}:${VERSION}
	podman push ${DOCKERHUB_REPO}:latest
