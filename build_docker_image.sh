# 190815 7392 Reza Farrahi (reza.farrahi@nakisa.com)

version_number=$(cat docker_tag_version.txt); version_number=$((10#$version_number + 1)); version_number=$(printf "%03d" $version_number); echo $version_number; echo "$version_number" > docker_tag_version.txt;
docker build --no-cache -t imriss/docker-fluentd:"$version_number" ./v1.6/
docker push imriss/docker-fluentd:"$version_number"

