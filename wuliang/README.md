## develop

```shell
# install docker
# https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```


```shell
# clone source code
git clone https://github.com/wulianglongrd/envoy -b test-branch

# build image
docker build -t wuliang/envoy-dev:0.1 -f Dockerfile-wuliang .

# run container
docker run -d --privileged -p 127.0.0.1:2222:22 --name wuliang-envoy-dev --mount type=bind,source="$PWD",target="/home/user/envoy" wuliang/envoy-dev:0.1

# login container use ssh
ssh user@localhost -p2222

# build envoy
# https://github.com/envoyproxy/envoy/blob/ad15deb3cf2bb8531deeb5bb8043426795b46ba6/bazel/README.md#building-envoy-with-the-ci-docker-image
./ci/do_ci.sh dev
./ci/do_ci.sh debug

or
bazel build envoy -c dbg >> wuliang.log 2>&1 &

# run envoy
# https://www.envoyproxy.io/docs/envoy/latest/start/quick-start/run-envoy
# https://www.envoyproxy.io/docs/envoy/latest/operations/cli
bazel-bin/source/exe/envoy-static -c ./wuliang/demo.yaml --concurrency 2 --log-level debug --log-path demo.log

# gdb
gdb bazel-bin/source/exe/envoy-static
start -c ./wuliang/demo.yaml --concurrency 2 --log-level debug --log-path demo.log

# lldb
lldb
(lldb) file /home/user/envoy/bazel-bin/source/exe/envoy-static
(lldb) run -c /home/user/envoy/wuliang/demo.yaml --concurrency 2 --log-level trace --log-path demo.log

b ConnectionManagerImpl::onData
```
