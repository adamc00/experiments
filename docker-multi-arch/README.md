### Notes

https://docker-registry-browser.sdlocal.net/repo/devel/stratperlbase/tag/multi-arch

```
docker buildx use multi-arch
                                                                                                                                                                                                    
cd /Development/uWSGI

docker buildx inspect --bootstrap

docker buildx build --push --platform linux/arm64/v8,linux/amd64 --tag docker.sdlocal.net/devel/uwsgi:multi-arch .