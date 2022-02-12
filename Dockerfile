FROM buluma/docker-rockylinux8-ansible

LABEL maintainer="Michael Buluma <me@buluma.co.ke>"
LABEL build_date="2022-02-12"

WORKDIR /github/workspace

RUN dnf install -y rpmdevtools dnf-utils dnf-utils && \
    dnf clean all && \
    rm -r -f /var/cache/*

CMD spectool --get-files --all SPECS/*.spec && \
    yum-builddep --assumeyes SPECS/*.spec && \
    rpmbuild --define '_topdir /github/workspace' -ba SPECS/*.spec
