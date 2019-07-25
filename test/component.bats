#!/usr/bin/env bats
exe='dist/kubectl-neat'

@test "pod - json" {
    KUBECTL_OUTPUT=json run "$exe" <./test/fixtures/pod-1-raw.json
    [ $status -eq 0 ]
    diff <(jq -S .<<<"$output") <(jq -S . ./test/fixtures/pod-1-neat.json)
}

@test "service - json" {
    KUBECTL_OUTPUT=json run "$exe" <./test/fixtures/service-1-raw.json
    [ $status -eq 0 ]
    diff <(jq -S .<<<"$output") <(jq -S . ./test/fixtures/service-1-neat.json)
}

@test "pod - yaml" {
    KUBECTL_OUTPUT=yaml run "$exe" <./test/fixtures/pod-1-raw.yaml
    [ $status -eq 0 ]
    local ouputjson=$(yq r --tojson -<<<"$output")
    diff <(jq -S .<<<"$ouputjson") <(jq -S . ./test/fixtures/pod-1-neat.json)
}

@test "service - yaml" {
    KUBECTL_OUTPUT=yaml run "$exe" <./test/fixtures/service-1-raw.yaml
    [ $status -eq 0 ]
    local ouputjson=$(yq r --tojson -<<<"$output")
    diff <(jq -S .<<<"$ouputjson") <(jq -S . ./test/fixtures/service-1-neat.json)
}

