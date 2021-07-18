FROM cragonnyunt/development-docker:latest as downloader

RUN apt-get update && \
    apt-get install -y \
    cmake \
    build-essential

RUN curl -L -o /tmp/protoc-3.17.3-linux-x86_64.zip https://github.com/protocolbuffers/protobuf/releases/download/v3.17.3/protoc-3.17.3-linux-x86_64.zip && \
    7z x /tmp/protoc-3.17.3-linux-x86_64.zip -o/tmp/protoc && \
    find /tmp/protoc -type d -print0 | xargs -0 chmod 0755 && \
    find /tmp/protoc -type f -print0 | xargs -0 chmod 0644 && \
    chmod 755 /tmp/protoc/bin/protoc

RUN mkdir -p /tmp/grpc && \
    git clone --recurse-submodules -b v1.38.1 https://github.com/grpc/grpc /tmp/grpc

RUN bash -xc "\
    cd /tmp/grpc; \
    mkdir -p cmake/build; \
    pushd cmake/build; \
    cmake ../..; \
    make protoc grpc_cpp_plugin; \
    make protoc grpc_csharp_plugin; \
    make protoc grpc_node_plugin; \
    make protoc grpc_objective_c_plugin; \
    make protoc grpc_php_plugin; \
    make protoc grpc_ruby_plugin; \
    popd; \
    "

FROM cragonnyunt/development-docker:latest

COPY --from=downloader /tmp/protoc /usr/

COPY --from=downloader /tmp/grpc/cmake/build/grpc_cpp_plugin /usr/local/bin/grpc_cpp_plugin
COPY --from=downloader /tmp/grpc/cmake/build/grpc_csharp_plugin /usr/local/bin/grpc_csharp_plugin
COPY --from=downloader /tmp/grpc/cmake/build/grpc_node_plugin /usr/local/bin/grpc_node_plugin
COPY --from=downloader /tmp/grpc/cmake/build/grpc_objective_c_plugin /usr/local/bin/grpc_objective_c_plugin
COPY --from=downloader /tmp/grpc/cmake/build/grpc_php_plugin /usr/local/bin/grpc_php_plugin
COPY --from=downloader /tmp/grpc/cmake/build/grpc_ruby_plugin /usr/local/bin/grpc_ruby_plugin
