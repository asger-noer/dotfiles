export GOPRIVATE=github.com/JasperLabs/*

lint() {
    GIT_COMMIT=$(git rev-parse master)

    echo "Linter changes from $GIT_COMMIT..."
    golangci-lint run  --timeout="20m" --new-from-rev=$(git rev-parse master) --fix
}

upgrade_tools() {
    echo "Upgrading Caruso tools..."

    export HOMEBREW_NO_AUTO_UPDATE=1

    brew upgrade protobuf

    # Upgrade protoc-gen-go to the latest version
    go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
    if [ $? -ne 0 ]; then
        echo "Failed to upgrade protoc-gen-go"
        return 1
    fi

    # Upgrade protoc-gen-go-grpc to the latest version
    go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
    if [ $? -ne 0 ]; then
        echo "Failed to upgrade protoc-gen-go-grpc"
        return 1
    fi

    # Upgrade protoc-gen-validate to version v0.10.1
    go install github.com/envoyproxy/protoc-gen-validate@v0.10.1
    if [ $? -ne 0 ]; then
        echo "Failed to upgrade protoc-gen-validate"
        return 1
    fi

    # Upgrade mockery to the latest version
    go install github.com/vektra/mockery/v2@latest
    if [ $? -ne 0 ]; then
        echo "Failed to upgrade mockery"
        return 1
    fi

    # Upgrade golangci-lint to the latest version
    go install github.com/golangci/golangci-lint/v2/cmd/golangci-lint@latest
    if [ $? -ne 0 ]; then
        echo "Failed to upgrade golangci-lint"
        return 1
    fi

    echo "Caruso tools upgraded successfully!"
    return 0
}

alias up-tools=upgrade_tools
