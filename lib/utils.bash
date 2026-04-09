#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/anzellai/sky"
TOOL_NAME="sky"
TOOL_TEST="sky --help"

fail() {
	echo -e "asdf-$TOOL_NAME: $*"
	exit 1
}

curl_opts=(-fsSL)

if [ -n "${GITHUB_API_TOKEN:-}" ]; then
	curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

filter_versions() {
	local query=${1:-}

	if [ -z "$query" ]; then
		cat
	else
		awk -v query="$query" 'index($0, query) == 1'
	fi
}

list_github_tags() {
	git ls-remote --tags --refs "$GH_REPO" |
		grep -o 'refs/tags/.*' | cut -d/ -f3- |
		sed 's/^v//'
}

list_all_versions() {
	list_github_tags
}

latest_stable_version() {
	local query=${1:-}
	local version=
	local latest_curl_opts=(-sI)

	if [ -n "${GITHUB_API_TOKEN:-}" ]; then
		latest_curl_opts=("${latest_curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
	fi

	if [ -z "$query" ]; then
		local redirect_url
		redirect_url=$(curl "${latest_curl_opts[@]}" "$GH_REPO/releases/latest" | sed -n -e "s|^location: *||p" | sed -n -e "s|\r||p")
		if [[ "$redirect_url" != "$GH_REPO/releases" ]]; then
			version="$(printf "%s\n" "$redirect_url" | sed 's|.*/tag/v\{0,1\}||')"
		fi
	fi

	if [ -z "$version" ]; then
		version="$(list_all_versions | filter_versions "$query" | sort_versions | tail -n1 | xargs echo)"
	fi

	if [ -z "$version" ]; then
		fail "No versions found${query:+ matching \"$query\"}"
	fi

	printf "%s\n" "$version"
}

resolve_version() {
	local version=$1

	if [ "$version" = "latest" ]; then
		latest_stable_version ""
	else
		printf "%s\n" "$version"
	fi
}

get_platform() {
	case "$(uname -s)" in
	Darwin)
		echo "darwin"
		;;
	Linux)
		echo "linux"
		;;
	*)
		fail "Unsupported platform: $(uname -s)"
		;;
	esac
}

get_arch() {
	case "$(uname -m)" in
	x86_64 | amd64)
		echo "x64"
		;;
	arm64 | aarch64)
		echo "arm64"
		;;
	*)
		fail "Unsupported architecture: $(uname -m)"
		;;
	esac
}

get_release_filename() {
	printf "%s-%s-%s" "$TOOL_NAME" "$(get_platform)" "$(get_arch)"
}

download_release() {
	local version filename url
	version="$(resolve_version "$1")"
	filename="$2"

	url="$GH_REPO/releases/download/v${version}/$(get_release_filename)"

	echo "* Downloading $TOOL_NAME release $version..."
	curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
	local install_type="$1"
	local version="$2"
	local install_path="${3%/bin}/bin"

	if [ "$install_type" != "version" ]; then
		fail "asdf-$TOOL_NAME supports release installs only"
	fi

	(
		mkdir -p "$install_path"
		cp "$ASDF_DOWNLOAD_PATH/$TOOL_NAME" "$install_path/$TOOL_NAME"
		chmod +x "$install_path/$TOOL_NAME"

		local tool_cmd
		tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
		test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

		echo "$TOOL_NAME $version installation was successful!"
	) || (
		rm -rf "$install_path"
		fail "An error occurred while installing $TOOL_NAME $version."
	)
}
